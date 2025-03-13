import 'package:easy_solutions/src/base/ApiService/api_service.dart';

abstract class BaseApiService {
  ApiService apiService = DefaultApiService();
  static String baseUrl = "http://192.168.0.3:8000/";
  static String singUpEndpoint = "auth/signUp";
  static String singInEndpoint = "auth/signIn";
  static String resetPasswordEndpoint = "auth/request-password-reset";
  static String getUserDataEndpoint = "auth/get-user-data";
  static String refreshTokenEndpoint = "auth/refreshToken";
  static String googleSignInEndpoint = "auth/googleSignIn";
  static String updatePasswordEndpoint = "";
}

abstract class SignUpService extends BaseApiService {
  String endpoint = BaseApiService.baseUrl + BaseApiService.singUpEndpoint;

  Future<Map<String, dynamic>> signUp({
    required Map<String, dynamic> bodyParameters,
  });
}

abstract class SignInService extends BaseApiService {
  String endpoint = BaseApiService.baseUrl + BaseApiService.singInEndpoint;

  Future<Map<String, dynamic>> signIn({
    required Map<String, dynamic> bodyParameters,
  });
}

abstract class RefreshTokenService extends BaseApiService {
  String endpoint =
      BaseApiService.baseUrl + BaseApiService.refreshTokenEndpoint;

  Future<Map<String, dynamic>> getRefreshToken({
    required Map<String, dynamic> bodyParameters,
  });
}

abstract class ResetPasswordUserService extends BaseApiService {
  String endpoint =
      BaseApiService.baseUrl + BaseApiService.resetPasswordEndpoint;

  Future<Map<String, dynamic>> resetPassword({required String email});
}

abstract class GetUserAuthDataService extends BaseApiService {
  String endpoint = BaseApiService.baseUrl + BaseApiService.getUserDataEndpoint;

  getUserAuthData({required Map<String, dynamic> bodyParameters});
}
