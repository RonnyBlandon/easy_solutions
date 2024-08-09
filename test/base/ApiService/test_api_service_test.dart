import 'package:easy_solutions/src/base/ApiService/api_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'Mocks/test_api_mocks.dart';

abstract class _Constants {
  static Map<String, String> defaultHeaders = {
    'Content-type': 'application/json; charset=UTF-8',
  };
  static String postEndpoint = "https://jsonplaceholder.typicode.com/posts";
  static String getEndpoint = "https://jsonplaceholder.typicode.com/posts/1";
  static String putEndpoint = "https://jsonplaceholder.typicode.com/posts/1";
}

// Test correct Connection of Api Service
void main() {
  // Esta es la que vamos a testear
  final ApiService testApiService = DefaultApiService();

  group('Test correct Connection of Api Service', () {
    // Test correct post connection to jsonplaceholder
    test('Test correct post connection to jsonplaceholder', () async {
      final bodyParams =
          CorrectPostBodyParams(tittle: 'foo', body: 'bar', userId: 1);
      final result = await testApiService.getDataFromPostRecuest(
          bodyParameters: bodyParams.toMap(),
          url: _Constants.postEndpoint,
          headers: _Constants.defaultHeaders);

      expect(result, Map.from(result));
    });

    // Test correct get connection to jsonplaceholder
    test('Test correct get connection to jsonplaceholder', () async {
      final result = await testApiService.getDataFromGetRecuest(
          url: _Constants.getEndpoint);

      expect(result, Map.from(result));
    });

    // Test correct put connection to jsonplaceholder
    test('Test correct put connection to jsonplaceholder', () async {
      final body =
          CorrectPutBodyParams(id: 1, tittle: 'foo', body: 'bar', userId: 1);
      final result = await testApiService.getDataFromPutRecuest(
          bodyParameters: body.toMap(),
          url: _Constants.putEndpoint,
          headers: _Constants.defaultHeaders);

      expect(result, Map.from(result));
    });
  });
}
