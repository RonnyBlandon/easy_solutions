abstract class BaseRealtimeDatabaseService {
  String baseUrl = "http://192.168.0.3:8000/";
}

abstract class RealtimeDatabaseService extends BaseRealtimeDatabaseService {
  Future<Map<String, dynamic>> postData(
      {required Map<String, dynamic> bodyParameters, required String path});
  Future<Map<String, dynamic>> putData(
      {required Map<String, dynamic> bodyParameters, required String path});
  Future<dynamic> getData({required String path});
}
