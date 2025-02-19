import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/base/Constants/error_messages.dart';
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
  final RealtimeDatabaseService _realtimeDatabaseService;

  DefaultSaveUserDataRepository(
      {RealtimeDatabaseService? realtimeDatabaseService})
      : _realtimeDatabaseService =
            realtimeDatabaseService ?? DefaultRealtimeDatabaseService();

  @override
  Future<Result<UserDecodable, Failure>> saveUserData(
      {required UserBodyParameters parameters}) async {
    if (parameters.localId == null) {
      return Result.failure(Failure.fromMessage(
          message: AppFailureMessages.unExpectedErrorMessage));
    }
    // Creamos el path
    var path = _Paths.userCollection + parameters.localId!;

    try {
      final result = await _realtimeDatabaseService.putData(
          bodyParameters: parameters.toMap(), path: path);
      UserDecodable decodable = UserDecodable.fromMap(result);
      return Result.success(decodable);
    } on Failure catch (f) {
      return Result.failure(f);
    }
  }
}
