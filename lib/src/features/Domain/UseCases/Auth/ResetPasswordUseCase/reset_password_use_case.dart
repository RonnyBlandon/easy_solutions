import 'package:easy_solutions/src/features/Domain/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/data/Repositories/Auth/ResetPasswordRepository/reset_password_repository.dart';

abstract class ResetPasswordUseCase {
  Future<void> execute({required String email});
}

class DefaultResetPasswordUseCase extends ResetPasswordUseCase {
  // Dependencias
  final ResetPasswordRepository _resetPasswordRepository;

  DefaultResetPasswordUseCase(
      {ResetPasswordRepository? resetPasswordRepository})
      : _resetPasswordRepository =
            resetPasswordRepository ?? DefaultResetPasswordRepository();

  @override
  Future<void> execute({required String email}) {
    return _resetPasswordRepository.resetPassword(email: email);
  }
}
