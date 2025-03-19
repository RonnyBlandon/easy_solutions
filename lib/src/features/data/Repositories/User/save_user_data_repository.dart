import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/data/Decodables/User/user_decodable.dart';
import 'package:easy_solutions/src/features/data/Repositories/User/user_body_parameters.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Interfaces/interface.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Services/realtime_database_service.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';

abstract class _Paths {
  static String userCollection = "users/";
}

class DefaultSaveUserDataRepository extends SaveUserDataRepository {
  // Dependencias
  final RealtimeDataBaseService _realtimeDatabaseService;

  DefaultSaveUserDataRepository({
    RealtimeDataBaseService? realtimeDatabaseService,
  }) : _realtimeDatabaseService =
           realtimeDatabaseService ?? DefaultRealtimeDataBaseService();

  @override
  Future<Result<UserDecodable, Failure>> saveUserData({
    required UserBodyParameters parameters,
  }) async {
    // Creamos el path
    var path = _Paths.userCollection;

    try {
      final result = await _realtimeDatabaseService.putData(
        bodyParameters: parameters.toMap(),
        path: path,
        requiresAuth: true,
      );

      if (result.containsKey("detail")) {
        final detail = result["detail"];

        if (detail is List && detail.isNotEmpty && detail.first is Map) {
          // Caso 1: Estructura con lista de detalles
          final errorMessage = detail.first["msg"] ?? "Error desconocido";
          return Result.failure(errorMessage);
        } else if (detail is String) {
          // Caso 2: Estructura simple con mensaje de error
          return Result.failure(Failure.fromMessage(message: detail));
        }

        // Si llega aquí, es un formato inesperado
        return Result.failure(
          Failure.fromMessage(message: "Error desconocido del servidor."),
        );
      }

      UserDecodable decodable = UserDecodable.fromMap(result);
      return Result.success(decodable);
    } on Failure catch (f) {
      return Result.failure(f);
    }
  }
}
