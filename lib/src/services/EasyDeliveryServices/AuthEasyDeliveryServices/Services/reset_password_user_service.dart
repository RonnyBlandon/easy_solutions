import 'package:easy_solutions/src/services/EasyDeliveryServices/AuthEasyDeliveryServices/BodyParameters/reset_password_user_service_body_parameters.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/AuthEasyDeliveryServices/Interfaces/auth_api_interface.dart';

class DefaultResetPasswordUserService extends ResetPasswordUserService {
  @override
  Future<Map<String, dynamic>> resetPassword({required String email}) {
    final params = ResetPasswordBodyParameters(email: email);
    return apiService.getDataFromPostRequest(
        bodyParameters: params.toMap(), url: endpoint);
  }
}
