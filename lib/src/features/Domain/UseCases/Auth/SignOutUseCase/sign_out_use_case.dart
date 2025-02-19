import 'package:easy_solutions/src/base/Constants/local_storage_keys.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/LocalStorage/local_storage_use_case_parameters.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/LocalStorage/remove_local_storage_use_case.dart';

abstract class SignOutUseCase {
  Future<void> execute();
}

class DefaultSignOutUseCase extends SignOutUseCase {
  // Dependencias
  final RemoveLocalStorageUseCase _removeLocalStorageUseCase;

  DefaultSignOutUseCase({RemoveLocalStorageUseCase? removeLocalStorageUseCase})
      : _removeLocalStorageUseCase =
            removeLocalStorageUseCase ?? DefaultRemoveLocalStorageUseCase();

  @override
  Future<void> execute() async {
    return _removeLocalStorageUseCase.execute(
        parameters:
            RemoveLocalStorageParameters(key: LocalStorageKeys.accessToken));
  }
}
