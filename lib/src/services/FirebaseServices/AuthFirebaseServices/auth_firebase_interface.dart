import 'package:easy_solutions/src/base/ApiService/api_service.dart';

abstract class BaseFirebaseService {
  ApiService apiService = DefaultApiService();
  static String baseUrl = "https://identitytoolkit.googleapis.com/v1/";
  static String singUpEndpoint = "accounts:signUp?key=";
  static String singInEndpoint = "accounts:signInWithPassword?key=";
  static String adminToken = "AIzaSyC4behj4hdyn91BGC_2xOitc4uP4zdK6N8";
}

abstract class SingUpServices extends BaseFirebaseService {
  String endpoint = BaseFirebaseService.baseUrl +
      BaseFirebaseService.singUpEndpoint +
      BaseFirebaseService.adminToken;

  Future<Map<String, dynamic>> singUp(
      {required Map<String, dynamic> bodyParameters});
}

abstract class SingInServices extends BaseFirebaseService {
  String endpoint = BaseFirebaseService.baseUrl +
      BaseFirebaseService.singUpEndpoint +
      BaseFirebaseService.adminToken;

  Future<Map<String, dynamic>> singUp(
      {required Map<String, dynamic> bodyParameters});
}
