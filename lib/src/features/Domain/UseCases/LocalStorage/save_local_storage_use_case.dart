import 'package:easy_solutions/src/features/Domain/Interfaces/Interfaces.dart';
import 'package:easy_solutions/src/features/data/Repositories/LocalStorage/save_local_storage_repository.dart';

import 'local_storage_use_case_parameters.dart';

abstract class SaveLocalStorageUseCase {
  Future<void> execute({required SaveLocalStorageParameters parameters});
}

class DefaultSaveLocalStorageUseCase extends SaveLocalStorageUseCase {
  // Dependencias
  final SaveLocalStorageRepository _saveLocalStorageRepository;

  DefaultSaveLocalStorageUseCase(
      {SaveLocalStorageRepository? saveLocalStorageRepository})
      : _saveLocalStorageRepository =
            saveLocalStorageRepository ?? DefaultSaveLocalStorageRepository();

  @override
  Future<void> execute({required SaveLocalStorageParameters parameters}) async {
    _saveLocalStorageRepository.saveInLocalStorage(
        key: parameters.key, value: parameters.value);
  }
}
