import 'package:easy_solutions/src/services/EasyDeliveryServices/AuthEasyDeliveryServices/Interfaces/auth_api_interface.dart';

class DefaultGetUserAuthDataService extends GetUserAuthDataService {
  @override
  getUserAuthData({required Map<String, dynamic> bodyParameters}) {
    return apiService.getDataFromPostRequest(
        bodyParameters: bodyParameters, url: endpoint);
  }
}
