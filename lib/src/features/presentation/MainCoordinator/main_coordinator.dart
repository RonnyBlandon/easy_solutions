import 'package:easy_solutions/src/base/Constants/local_storage_keys.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/LocalStorage/fetch_local_storage_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/LocalStorage/local_storage_use_case_parameters.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/User/ValidateCurrentUserUseCase/validate_current_user_use_case.dart';

class RoutesPath {
  static String welcomePath = "welcome";
  static String tabsPath = "tabs";
}

class MainCoordinator {
  // Dependencias
  final FetchLocalStorageUseCase _fetchLocalStorageUseCase;
  final ValidateCurrentUserUseCase _validateCurrentUserUseCase;

  MainCoordinator(
      {FetchLocalStorageUseCase? fetchLocalStorageUseCase,
      ValidateCurrentUserUseCase? validateCurrentUserUseCase})
      : _fetchLocalStorageUseCase =
            fetchLocalStorageUseCase ?? DefaultFetchLocalStorageUseCase(),
        _validateCurrentUserUseCase =
            validateCurrentUserUseCase ?? DefaultValidateCurrentUserUseCase();

  Future<String?> start() {
    return _isUserLogged().then((value) {
      return value == null ? RoutesPath.welcomePath : RoutesPath.tabsPath;
    });
  }

  Future<String?> _isUserLogged() async {
    var idToken = await _fetchLocalStorageUseCase.execute(
        parameters: FetchLocalStorageParameters(key: LocalStorageKeys.idToken));

    // Revisar si el usuario esta guardado
    if (idToken == null) {
      return null;
    }

    // Hay un token guardado, vamos a comprobar que el usuario existe aún en Firebase
    var isUserValid =
        await _validateCurrentUserUseCase.execute(idToken: idToken);

    if (isUserValid) {
      return idToken;
    } else {
      return null;
    }
  }
}
