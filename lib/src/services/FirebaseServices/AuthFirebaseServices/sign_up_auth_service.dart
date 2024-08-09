import 'package:easy_solutions/src/services/FirebaseServices/AuthFirebaseServices/auth_firebase_interface.dart';

class DefaultSignUpService extends SingUpServices {
  @override
  Future<Map<String, dynamic>> singUp({required Map<String, dynamic> bodyParameters}) {
    return apiService.getDataFromPostRecuest(bodyParameters: bodyParameters, url: endpoint)
  }

}