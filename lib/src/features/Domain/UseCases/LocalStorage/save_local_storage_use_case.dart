import 'package:easy_solutions/src/base/Constants/local_storage_keys.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/LocalStorage/fetch_local_storage_use_case.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/data/Repositories/LocalStorage/save_local_storage_repository.dart';

import 'local_storage_use_case_parameters.dart';

abstract class SaveLocalStorageUseCase {
  Future<void> execute({required SaveLocalStorageParameters parameters});
  Future<void> saveRecentSearchInLocalStorage({required String businessId});
  Future<void> clearRecentSearchInLocalStorage();
}

class DefaultSaveLocalStorageUseCase extends SaveLocalStorageUseCase {
  // Dependencias
  final SaveLocalStorageRepository _saveLocalStorageRepository;
  final FetchLocalStorageUseCase _fetchLocalStorageUseCase;

  DefaultSaveLocalStorageUseCase(
      {SaveLocalStorageRepository? saveLocalStorageRepository,
      FetchLocalStorageUseCase? fetchLocalStorageUseCase})
      : _saveLocalStorageRepository =
            saveLocalStorageRepository ?? DefaultSaveLocalStorageRepository(),
        _fetchLocalStorageUseCase =
            fetchLocalStorageUseCase ?? DefaultFetchLocalStorageUseCase();

  @override
  Future<void> execute({required SaveLocalStorageParameters parameters}) async {
    _saveLocalStorageRepository.saveInLocalStorage(
        key: parameters.key, value: parameters.value);
  }

  @override
  Future<void> clearRecentSearchInLocalStorage() {
    return _saveLocalStorageRepository.saveRecentSearchInLocalStorage(
        key: LocalStorageKeys.recentSearches, value: []);
  }

  @override
  Future<void> saveRecentSearchInLocalStorage(
      {required String businessId}) async {
    final businessIds = await _fetchLocalStorageUseCase.fetchRecentSearches();
    if (!businessIds.contains(businessId)) {
      businessIds.add(businessId);
      return _saveLocalStorageRepository.saveRecentSearchInLocalStorage(
          key: LocalStorageKeys.recentSearches, value: businessIds);
    }
  }
}