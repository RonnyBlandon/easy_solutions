import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/data/Repositories/LocalStorage/remove_local_storage_repository.dart';

import 'local_storage_use_case_parameters.dart';

abstract class RemoveLocalStorageUseCase {
  Future<void> execute({required RemoveLocalStorageParameters parameters});
}

class DefaultRemoveLocalStorageUseCase extends RemoveLocalStorageUseCase {
  // Dependencias
  final RemoveLocalStorageRepository _removeLocalStorageRepository;

  DefaultRemoveLocalStorageUseCase(
      {RemoveLocalStorageRepository? removeLocalStorageRepository})
      : _removeLocalStorageRepository = removeLocalStorageRepository ??
            DefaultRemoveLocalStorageRepository();

  @override
  Future<void> execute(
      {required RemoveLocalStorageParameters parameters}) async {
    return await _removeLocalStorageRepository.removeLocalStorage(
        key: parameters.key);
  }
}
