import 'package:easy_solutions/src/features/Domain/UseCases/Auth/SignOutUseCase/sign_out_use_case.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/loading_state_provider.dart';

abstract class MenuViewModelInput {
  late LoadingStateProvider loadingStatusState;
  Future<void> signOut();
  void initState({required LoadingStateProvider loadingState});
}

abstract class MenuViewModel extends MenuViewModelInput {}

class DefaultMenuViewModel extends MenuViewModel {
  // Depnendencias
  final SignOutUseCase _signOutUseCase;

  DefaultMenuViewModel({SignOutUseCase? signOutUseCase})
      : _signOutUseCase = signOutUseCase ?? DefaultSignOutUseCase();

  @override
  void initState({required LoadingStateProvider loadingState}) {
    loadingStatusState = loadingState;
  }

  @override
  Future<void> signOut() {
    loadingStatusState.setLoadingState(isLoading: true);

    return _signOutUseCase
        .execute()
        .then((_) => loadingStatusState.setLoadingState(isLoading: false));
  }
}
