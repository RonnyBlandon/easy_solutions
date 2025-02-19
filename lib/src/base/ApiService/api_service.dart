import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:easy_solutions/src/base/ApiService/app_error.dart';

abstract class _Exceptions {
  static const String socketExceptionMessage = "No internet Connection";
  static const String httpException = "Couldn't find the path";
  static const String formatException = "Bad response format";
  static const String timeOutException =
      "⏳ Tiempo de espera agotado, intenta de nuevo.";
}

abstract class ApiService {
  Future<Map<String, dynamic>> getDataFromPostRequest({
    required Map<String, dynamic> bodyParameters,
    required String url,
    Map<String, String>? headers,
  });
  Future<Map<String, dynamic>> getDataFromPutRequest({
    required Map<String, dynamic> bodyParameters,
    required String url,
    Map<String, String>? headers,
  });
  Future<dynamic> getDataFromGetRequest({
    required String url,
    Map<String, String>? headers,
  });
}

class DefaultApiService extends ApiService {
  // Método para solicitudes GET
  @override
  Future<dynamic> getDataFromGetRequest({
    required String url,
    Map<String, String>? headers,
  }) async {
    final parsedUrl = Uri.parse(url);
    final response = await http
        .get(parsedUrl,
            headers: headers ??
                {
                  "Content-Type": "application/json",
                })
        .timeout(const Duration(seconds: 20));

    try {
      if (response.statusCode.toString().contains('20')) {
        var jsonData = jsonDecode(response.body);
        if (jsonData == null) {
          throw Failure.fromMessage(message: _Exceptions.httpException);
        } else {
          return jsonData; // Puede ser un Map o una List
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

  // Método para solicitudes POST
  @override
  Future<Map<String, dynamic>> getDataFromPostRequest({
    required Map<String, dynamic> bodyParameters,
    required String url,
    Map<String, String>? headers,
  }) async {
    final parsedUrl = Uri.parse(url);
    final body = jsonEncode(bodyParameters); // Convertir el cuerpo a JSON
    final response = await http
        .post(parsedUrl,
            headers: {
              "Content-Type": "application/json",
              ...?headers, // Mezclar encabezados adicionales si existen
            },
            body: body)
        .timeout(const Duration(seconds: 20));
    try {
      if (response.statusCode.toString().contains('20')) {
        var jsonData = jsonDecode(response.body);
        if (jsonData == null) {
          throw Failure.fromMessage(message: _Exceptions.httpException);
        } else {
          return jsonData;
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

  // Método para solicitudes PUT
  @override
  Future<Map<String, dynamic>> getDataFromPutRequest({
    required Map<String, dynamic> bodyParameters,
    required String url,
    Map<String, String>? headers,
  }) async {
    final parsedUrl = Uri.parse(url);
    final body = jsonEncode(bodyParameters);
    final response = await http
        .put(parsedUrl,
            headers: {
              "Content-Type": "application/json",
              ...?headers,
            },
            body: body)
        .timeout(const Duration(seconds: 20));

    try {
      if (response.statusCode.toString().contains('20')) {
        var jsonData = jsonDecode(response.body);
        if (jsonData == null) {
          throw Failure.fromMessage(message: _Exceptions.httpException);
        } else {
          return jsonData;
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
