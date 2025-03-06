import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:easy_solutions/src/base/RefreshTokenAuthService/refresh_token_auth_service.dart';
import 'package:easy_solutions/src/base/TokenStorageService/token_storage_service.dart';
import 'package:http/http.dart' as http;
import 'package:easy_solutions/src/base/ApiService/app_error.dart';

abstract class _Exceptions {
  static const String socketExceptionMessage = "No internet Connection";
  static const String httpException = "Couldn't find the path";
  static const String formatException = "Bad response format";
  static const String timeOutException =
      "Tiempo de espera agotado, intenta de nuevo.";
}

abstract class ApiService {
  Future<Map<String, dynamic>> getDataFromPostRequest({
    required Map<String, dynamic> bodyParameters,
    required String url,
    bool requiresAuth = false,
  });

  Future<Map<String, dynamic>> getDataFromPutRequest({
    required Map<String, dynamic> bodyParameters,
    required String url,
    bool requiresAuth = false,
  });

  Future<Map<String, dynamic>> getDataFromGetRequest({
    required String url,
    bool requiresAuth = false,
  });

  Future<Map<String, dynamic>> getDataFromDeleteRequest({
    required String url,
    bool requiresAuth = false,
  });
}

class DefaultApiService extends ApiService {
  final TokenStorageService _tokenStorage = TokenStorageService();

  // Método para manejar los headers con o sin token
  Future<Map<String, String>> _getHeaders({bool requiresAuth = false}) async {
    final headers = {"Content-Type": "application/json"};

    if (requiresAuth) {
      String? accessToken = await _tokenStorage.getAccessToken();

      if (accessToken == null) {
        final refreshed = await RefreshTokenAuthService().refreshAccessToken();
        if (refreshed) {
          accessToken = await _tokenStorage.getAccessToken();
        } else {
          throw Failure.fromMessage(
              message: "Token expirado. Inicia sesión nuevamente.");
        }
      }
      headers["Authorization"] = "Bearer $accessToken";
    }

    return headers;
  }

  // Método para solicitudes GET
  @override
  Future<Map<String, dynamic>> getDataFromGetRequest({
    required String url,
    bool requiresAuth = false,
  }) async {
    final parsedUrl = Uri.parse(url);
    final headers = await _getHeaders(requiresAuth: requiresAuth);

    final response = await http
        .get(parsedUrl, headers: headers)
        .timeout(const Duration(seconds: 25));

    return await _handleResponse(response,
        () => getDataFromGetRequest(url: url, requiresAuth: requiresAuth), requiresAuth: requiresAuth);
  }

  // Método para solicitudes POST
  @override
  Future<Map<String, dynamic>> getDataFromPostRequest({
    required Map<String, dynamic> bodyParameters,
    required String url,
    bool requiresAuth = false,
  }) async {
    final parsedUrl = Uri.parse(url);
    final headers = await _getHeaders(requiresAuth: requiresAuth);
    final body = jsonEncode(bodyParameters);

    final response = await http
        .post(parsedUrl, headers: headers, body: body)
        .timeout(const Duration(seconds: 25));

    return await _handleResponse(response, () => getDataFromPostRequest(
        bodyParameters: bodyParameters, url: url, requiresAuth: requiresAuth), requiresAuth: requiresAuth);
  }

  // Método para solicitudes PUT
  @override
  Future<Map<String, dynamic>> getDataFromPutRequest({
    required Map<String, dynamic> bodyParameters,
    required String url,
    bool requiresAuth = false,
  }) async {
    final parsedUrl = Uri.parse(url);
    final headers = await _getHeaders(requiresAuth: requiresAuth);
    final body = jsonEncode(bodyParameters);

    final response = await http
        .put(parsedUrl, headers: headers, body: body)
        .timeout(const Duration(seconds: 25));

    return await _handleResponse(response, () => getDataFromPutRequest(
        bodyParameters: bodyParameters, url: url, requiresAuth: requiresAuth), requiresAuth: requiresAuth);
  }

  // Método para solicitudes DELETE
  @override
  Future<Map<String, dynamic>> getDataFromDeleteRequest({
    required String url,
    bool requiresAuth = false,
  }) async {
    final parsedUrl = Uri.parse(url);
    final headers = await _getHeaders(requiresAuth: requiresAuth);

    final response = await http
        .delete(parsedUrl, headers: headers)
        .timeout(const Duration(seconds: 25));

    return await _handleResponse(response, () => getDataFromDeleteRequest(
        url: url, requiresAuth: requiresAuth), requiresAuth: requiresAuth);
  }

  // Método para manejar respuestas y refrescar tokens si es necesario
  Future<Map<String, dynamic>> _handleResponse(
      http.Response response, Future<Map<String, dynamic>> Function() retryRequest, {required bool requiresAuth}) async {
    try {
      if (response.statusCode.toString().contains('20')) {
        var jsonData = jsonDecode(response.body);
        if (jsonData == null) {
          throw Failure.fromMessage(message: _Exceptions.httpException);
        } else {
          return jsonData;
        }
      } else if (response.statusCode == 401 && requiresAuth) {
        // Intentar refrescar el token si es 401
        final refreshed = await RefreshTokenAuthService().refreshAccessToken();
        if (refreshed) {
          return await retryRequest(); // Reintentar con nuevo token
        } else {
          throw Failure.fromMessage(
              message: "Token expirado. Inicia sesión nuevamente.");
        }
      } else {
        throw Failure.fromBody(body: response.body);
      }
    } on SocketException {
      throw Failure.fromMessage(message: _Exceptions.socketExceptionMessage);
    } on HttpException {
      throw Failure.fromMessage(message: _Exceptions.httpException);
    } on FormatException {
      throw Failure.fromMessage(message: _Exceptions.formatException);
    } on TimeoutException {
      throw Failure.fromMessage(message: _Exceptions.timeOutException);
    }
  }
}
