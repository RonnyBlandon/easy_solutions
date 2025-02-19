import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/Domain/Entities/User/user_entity.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/GoogleSignInUseCase/google_sign_in_use_case.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/loading_state_provider.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';

abstract class WelcomePageViewModelInput {
  Future<Result<UserEntity, Failure>> signInWithGoogle();
}

abstract class WelcomePageViewModel extends WelcomePageViewModelInput
    with BaseViewModel {}

class DefaultWelcomePageViewModel extends WelcomePageViewModel {
  // Dependencias
  final GoogleSignInUseCase _googleSignInUseCase;

  DefaultWelcomePageViewModel({GoogleSignInUseCase? googleSignInUseCase})
      : _googleSignInUseCase =
            googleSignInUseCase ?? DefaultGoogleSignInUseCase();

  @override
  void initState({required LoadingStateProvider loadingStateProvider}) {
    loadingState = loadingStateProvider;
  }

  @override
  Future<Result<UserEntity, Failure>> signInWithGoogle() {
    return _googleSignInUseCase.execute();
  }
}
