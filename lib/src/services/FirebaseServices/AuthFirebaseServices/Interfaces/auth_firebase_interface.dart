import 'package:easy_solutions/src/base/ApiService/api_service.dart';

abstract class BaseFirebaseService {
  ApiService apiService = DefaultApiService();
  static String baseUrl = "https://identitytoolkit.googleapis.com/v1/";
  static String singUpEndpoint = "accounts:signUp?key=";
  static String singInEndpoint = "accounts:signInWithPassword?key=";
  static String adminToken = "AIzaSyC4behj4hdyn91BGC_2xOitc4uP4zdK6N8";
}

abstract class SignUpService extends BaseFirebaseService {
  String endpoint = BaseFirebaseService.baseUrl +
      BaseFirebaseService.singUpEndpoint +
      BaseFirebaseService.adminToken;

  Future<Map<String, dynamic>> signUp(
      {required Map<String, dynamic> bodyParameters});
}

abstract class SignInService extends BaseFirebaseService {
  String endpoint = BaseFirebaseService.baseUrl +
      BaseFirebaseService.singInEndpoint +
      BaseFirebaseService.adminToken;

  Future<Map<String, dynamic>> signIn(
      {required Map<String, dynamic> bodyParameters});
}
