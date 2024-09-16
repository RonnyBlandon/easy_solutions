import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/services/FirebaseServices/AuthFirebaseServices/Decodables/reset_password_decodable.dart';
import 'package:easy_solutions/src/services/FirebaseServices/AuthFirebaseServices/Interfaces/auth_firebase_interface.dart';
import 'package:easy_solutions/src/services/FirebaseServices/AuthFirebaseServices/Services/reset_password_user_service.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';

class DefaultResetPasswordRepository extends ResetPasswordRepository {
  // Dependencias
  final ResetPasswordUserService _resetPasswordUserService;

  DefaultResetPasswordRepository(
      {ResetPasswordUserService? resetPasswordUserService})
      : _resetPasswordUserService =
            resetPasswordUserService ?? DefaultResetPasswordUserService();

  @override
  Future<Result<ResetPasswordDecodable, Failure>> resetPassword(
      {required String email}) async {
    try {
      final result =
          await _resetPasswordUserService.resetPassword(email: email);
      ResetPasswordDecodable decodable = ResetPasswordDecodable.fromMap(result);
      return Result.success(decodable);
    } on Failure catch (f) {
      return Result.failure(
          Failure.getFirebaseAuthErrorMessage(error: f.error));
    }
  }
}
