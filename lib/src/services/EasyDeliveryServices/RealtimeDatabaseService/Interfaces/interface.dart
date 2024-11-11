abstract class BaseRealtimeDatabaseService {
  String baseUrl = "https://easy-delivery-78b08-default-rtdb.firebaseio.com/";
  String endUrl = ".json";
}

abstract class RealtimeDatabaseService extends BaseRealtimeDatabaseService {
  Future<Map<String, dynamic>> postData(
      {required Map<String, dynamic> bodyParameters, required String path});
  Future<Map<String, dynamic>> putData(
      {required Map<String, dynamic> bodyParameters, required String path});
  Future<Map<String, dynamic>> getData({required String path});
}
