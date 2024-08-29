import 'package:easy_solutions/src/services/FirebaseServices/AuthFirebaseServices/Interfaces/auth_firebase_interface.dart';

class DefaultGetUserAuthDataService extends GetUserAuthDataService {
  @override
  getUserAuthData({required Map<String, dynamic> bodyParameters}) {
    return apiService.getDataFromPostRequest(
        bodyParameters: bodyParameters, url: endpoint);
  }
}
