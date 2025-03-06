import 'package:easy_solutions/src/features/Domain/UseCases/LocalStorage/fetch_local_storage_use_case.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/data/Repositories/LocalStorage/save_local_storage_repository.dart';

import 'local_storage_use_case_parameters.dart';

abstract class SaveLocalStorageUseCase {
  Future<void> execute({required SaveLocalStorageParameters parameters});
  Future<void> saveRecentProductSearchInLocalStorage({required String businessId, required String productId});
  Future<void> clearRecentProductSearchInLocalStorage({required String businessId});
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
  Future<void> clearRecentProductSearchInLocalStorage({required String businessId}) {
    return _saveLocalStorageRepository.saveRecentSearchInLocalStorage(
        key: businessId, value: []);
  }

  @override
  Future<void> saveRecentProductSearchInLocalStorage({
    required String businessId,
    required String productId,}) async {
    final productIds = await _fetchLocalStorageUseCase.fetchRecentProductSearches(businessId: businessId);

    // Si el producto ya está en la lista, se elimina para reinsertarlo al final
    productIds.remove(productId);
    productIds.add(productId);

    // Mantener solo los últimos 10 elementos
    if (productIds.length > 10) {
    productIds.removeAt(0); // Eliminar el más antiguo (primer elemento)
    }

    return _saveLocalStorageRepository.saveRecentSearchInLocalStorage(
      key: businessId,
      value: productIds,
    );
  }

}