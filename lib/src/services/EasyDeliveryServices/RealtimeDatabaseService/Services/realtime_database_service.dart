import 'package:easy_solutions/src/base/ApiService/api_service.dart';
import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Interfaces/interface.dart';

class DefaultRealtimeDatabaseService extends RealtimeDatabaseService {
  final ApiService _apiService;

  DefaultRealtimeDatabaseService({ApiService? apiService})
      : _apiService = apiService ?? DefaultApiService();

  @override
  Future<dynamic> getData({required String path}) async {
    var endpoint = baseUrl + path;

    try {
      final result = await _apiService.getDataFromGetRequest(url: endpoint);
      return result;
    } on Failure catch (f) {
      return f.error;
    }
  }

  @override
  Future<Map<String, dynamic>> postData(
      {required Map<String, dynamic> bodyParameters,
      required String path}) async {
    var endpoint = baseUrl + path;
    try {
      final result = await _apiService.getDataFromPostRequest(
          bodyParameters: bodyParameters, url: endpoint);
      return result;
    } on Failure catch (f) {
      return f.error;
    }
  }

  @override
  Future<Map<String, dynamic>> putData(
      {required Map<String, dynamic> bodyParameters,
      required String path}) async {
    var endpoint = baseUrl + path;

    try {
      final result = await _apiService.getDataFromPutRequest(
          bodyParameters: bodyParameters, url: endpoint);
      return result;
    } on Failure catch (f) {
      return f.error;
    }
  }
}
