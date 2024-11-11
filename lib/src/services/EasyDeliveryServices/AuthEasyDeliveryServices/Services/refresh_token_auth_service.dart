import 'package:easy_solutions/src/services/EasyDeliveryServices/AuthEasyDeliveryServices/Interfaces/auth_api_interface.dart';

class DefaultRefreshTokenService extends RefreshTokenService {
  @override
  Future<Map<String, dynamic>> getRefreshToken(
      {required Map<String, dynamic> bodyParameters}) {
    return apiService.getDataFromPostRequest(
        url: endpoint, bodyParameters: bodyParameters);
  }
}
