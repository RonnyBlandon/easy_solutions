import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/data/Repositories/Auth/ResetPasswordRepository/reset_password_repository.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';

abstract class ResetPasswordUseCase {
  Future<Result<bool, Failure>> execute({required String email});
}

class DefaultResetPasswordUseCase extends ResetPasswordUseCase {
  // Dependencias
  final ResetPasswordRepository _resetPasswordRepository;

  DefaultResetPasswordUseCase(
      {ResetPasswordRepository? resetPasswordRepository})
      : _resetPasswordRepository =
            resetPasswordRepository ?? DefaultResetPasswordRepository();

  @override
  Future<Result<bool, Failure>> execute({required String email}) {
    return _resetPasswordRepository.resetPassword(email: email).then((result) {
      switch (result.status) {
        case ResultStatus.success:
          return Result.success(true);
        case ResultStatus.error:
          return Result.failure(result.error);
      }
    });
  }
}
