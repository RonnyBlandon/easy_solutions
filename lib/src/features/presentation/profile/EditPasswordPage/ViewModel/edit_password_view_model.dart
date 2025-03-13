import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Auth/ResetPasswordUseCase/reset_password_use_case.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/loading_state_provider.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';

abstract class EditPasswordViewModelInput {
  late String email;
  Future<void> resetPassword();
}

abstract class EditPasswordViewModel extends EditPasswordViewModelInput
    with BaseViewModel {}

class DefaultEditPasswordViewModel extends EditPasswordViewModel {
  // Dependencias
  final ResetPasswordUseCase _resetPasswordUseCase;

  DefaultEditPasswordViewModel({ResetPasswordUseCase? resetPasswordUseCase})
    : _resetPasswordUseCase =
          resetPasswordUseCase ?? DefaultResetPasswordUseCase();

  @override
  void initState({required LoadingStateProvider loadingStateProvider}) {
    loadingState = loadingStateProvider;
  }

  @override
  Future<Result<bool, Failure>> resetPassword() {
    loadingState.setLoadingState(isLoading: true);

    return _resetPasswordUseCase.execute(email: email).then((result) {
      switch (result.status) {
        case ResultStatus.success:
          loadingState.setLoadingState(isLoading: false);
          return Result.success(true);
        case ResultStatus.error:
          loadingState.setLoadingState(isLoading: false);
          return Result.failure(result.error);
      }
    });
  }
}
