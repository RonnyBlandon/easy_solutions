import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/data/Repositories/LocalStorage/fetch_local_storage_repository.dart';

import 'local_storage_use_case_parameters.dart';

abstract class FetchLocalStorageUseCase {
  Future<String?> execute({required FetchLocalStorageParameters parameters});
  Future<List<String>> fetchRecentProductSearches({required String businessId});
}

class DefaultFetchLocalStorageUseCase extends FetchLocalStorageUseCase {
  // Dependencias
  final FetchLocalStorageRepository _fetchLocalStorageRepository;

  DefaultFetchLocalStorageUseCase(
      {FetchLocalStorageRepository? fetchLocalStorageRepository})
      : _fetchLocalStorageRepository =
            fetchLocalStorageRepository ?? DefaultFetchLocalStorageRepository();

  @override
  Future<String?> execute(
      {required FetchLocalStorageParameters parameters}) async {
    var value = await _fetchLocalStorageRepository.fetchInLocalStorage(
        key: parameters.key);
    return value;
  }

  @override
  Future<List<String>> fetchRecentProductSearches({required String businessId}) async {
    final recentSearch =
        await _fetchLocalStorageRepository.fetchRecentProductSearches(businessId: businessId);
    return recentSearch ?? [];
  }
}
