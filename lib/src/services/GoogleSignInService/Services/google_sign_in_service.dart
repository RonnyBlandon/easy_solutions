import 'package:easy_solutions/src/base/ApiService/api_service.dart';
import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Interfaces/interface.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Services/realtime_database_service.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Entities/google_user_entity.dart';
import '../Interfaces/interfaces.dart';

class DefaultGoogleSignInService extends GoogleSignInService {
  final String _path = "users/";

  // Dependencias
  final RealtimeDatabaseService _realtimeDatabaseService;
  final ApiService _apiService;

  DefaultGoogleSignInService({
    RealtimeDatabaseService? realtimeDatabaseService,
    ApiService? apiService,
  }) : _realtimeDatabaseService =
           realtimeDatabaseService ?? DefaultRealtimeDatabaseService(),
       _apiService = apiService ?? DefaultApiService();

  @override
  Future<bool> isUserInDatabase() async {
    final fullpath = _path;

    try {
      final result = await _realtimeDatabaseService.getData(
        path: fullpath,
        requiresAuth: true,
      );
      return result.isNotEmpty;
    } on Failure {
      return false;
    }
  }

  @override
  Future<GoogleSignInUserEntity> signInWithGoogle() async {
    // Desconectar cualquier cuenta de Google previamente conectada
    await GoogleSignIn().signOut();

    // Iniciar el flujo de autenticación
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        throw Exception("Error: el usuario no pudo autenticarse con Google.");
      }

      // Obtener los detalles de autenticación del usuario
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;
      if (googleAuth == null || (googleAuth.accessToken == null)) {
        throw Exception("Error: No se pudo obtener el access token de Google.");
      }

      // Enviar el token de ID al backend en FastAPI
      return googleSignIn(
        bodyParameters: {"access_token": googleAuth.accessToken},
      ).then((result) {
        switch (result.status) {
          case ResultStatus.success:
            return result.value!;
          case ResultStatus.error:
            throw Exception(
              "Error en el inicio de sesión con Google: ${result.error?.message}",
            );
        }
      });
    } catch (e) {
      throw Exception("Error: No se puede usar la autenticación de Google.");
    }
  }

  @override
  Future<Result<GoogleSignInUserEntity, Failure>> googleSignIn({
    required Map<String, dynamic> bodyParameters,
  }) async {
    try {
      final result = await _apiService.getDataFromPostRequest(
        bodyParameters: bodyParameters,
        url: endpoint,
      );
      GoogleSignInUserEntity entity = GoogleSignInUserEntity.fromMap(result);
      return Result.success(entity);
    } on Failure catch (f) {
      return Result.failure(Failure.getApiAuthErrorMessage(error: f.error));
    }
  }
}
