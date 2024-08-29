import 'package:easy_solutions/src/services/FirebaseServices/AuthFirebaseServices/BodyParameters/reset_password_user_service_body_parameters.dart';
import 'package:easy_solutions/src/services/FirebaseServices/AuthFirebaseServices/Interfaces/auth_firebase_interface.dart';

class DefaultResetPasswordUserService extends ResetPasswordUserService {
  final String _requestType = "PASSWORD_RESET";

  @override
  Future<Map<String, dynamic>> resetPassword({required String email}) {
    final params =
        ResetPasswordBodyParameters(requestType: _requestType, email: email);
    return apiService.getDataFromPostRequest(
        bodyParameters: params.toMap(), url: endpoint);
  }
}
