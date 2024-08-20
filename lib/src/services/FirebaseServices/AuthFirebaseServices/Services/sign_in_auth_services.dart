import 'package:easy_solutions/src/services/FirebaseServices/AuthFirebaseServices/Interfaces/auth_firebase_interface.dart';

class DefaultSignInServices extends SignInService {
  @override
  Future<Map<String, dynamic>> signIn(
      {required Map<String, dynamic> bodyParameters}) {
    return apiService.getDataFromPostRequest(
        bodyParameters: bodyParameters, url: endpoint);
  }
}
