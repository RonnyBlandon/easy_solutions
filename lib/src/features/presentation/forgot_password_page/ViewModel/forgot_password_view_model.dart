import 'package:easy_solutions/src/features/Domain/UseCases/Auth/ResetPasswordUseCase/reset_password_use_case.dart';

abstract class ForgotPasswordViewModelInput {
  late String email;
  Future<void> resetPassword();
}

abstract class ForgotPasswordViewModel extends ForgotPasswordViewModelInput {}

class DefaultForgotPasswordViewModel extends ForgotPasswordViewModel {
  // Dependencias
  final ResetPasswordUseCase _resetPasswordUseCase;

  DefaultForgotPasswordViewModel({ResetPasswordUseCase? resetPasswordUseCase})
      : _resetPasswordUseCase =
            resetPasswordUseCase ?? DefaultResetPasswordUseCase();

  @override
  Future<void> resetPassword() {
    return _resetPasswordUseCase.execute(email: email);
  }
}
