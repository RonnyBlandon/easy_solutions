abstract class BaseRealtimeDataBaseService {
  String baseUrl = "http://192.168.0.3:8000/";
}

abstract class RealtimeDataBaseService extends BaseRealtimeDataBaseService {
  Future<Map<String, dynamic>> getData({
    required String path,
    required bool requiresAuth,
  });
  Future<Map<String, dynamic>> postData({
    required Map<String, dynamic> bodyParameters,
    required String path,
    required bool requiresAuth,
  });
  Future<Map<String, dynamic>> putData({
    required Map<String, dynamic> bodyParameters,
    required String path,
    required bool requiresAuth,
  });
  Future<Map<String, dynamic>> deleteData({
    required String path,
    required bool requiresAuth,
  });
}
