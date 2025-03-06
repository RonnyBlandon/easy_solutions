import 'package:easy_solutions/src/features/Domain/Entities/Products/products_entity.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/LocalStorage/fetch_local_storage_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/LocalStorage/save_local_storage_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Products/products_use_case.dart';

abstract class SearchViewModelInput {
  Future<ProductListEntity> fetchProductListByQuery(
      {required String businessId, required String query});
  Future<ProductListEntity> fetchProductListByRecentSearches({required String businessId});
  Future<void> clearRecentProductSearchInLocalStorage({required String businessId});
}

abstract class SearchViewModel extends SearchViewModelInput {}

class DefaultSearchViewModel extends SearchViewModel {
  // Dependencies;
  final FetchProductUseCase _fetchProductUseCase;
  final FetchLocalStorageUseCase _fetchLocalStorageUseCase;
  final SaveLocalStorageUseCase _saveLocalStorageUseCase;

  DefaultSearchViewModel(
      {FetchProductUseCase? fetchProductUseCase,
      FetchLocalStorageUseCase? fetchLocalStorageUseCase,
      SaveLocalStorageUseCase? saveLocalStorageUseCase})
      : _fetchProductUseCase =
            fetchProductUseCase ?? DefaultFetchProductUseCase(),
        _fetchLocalStorageUseCase =
            fetchLocalStorageUseCase ?? DefaultFetchLocalStorageUseCase(),
        _saveLocalStorageUseCase =
            saveLocalStorageUseCase ?? DefaultSaveLocalStorageUseCase();

  @override
  Future<void> clearRecentProductSearchInLocalStorage({required String businessId}) {
    return _saveLocalStorageUseCase.clearRecentProductSearchInLocalStorage(businessId: businessId);
  }

  @override
  Future<ProductListEntity> fetchProductListByQuery(
      {required String businessId, required String query}) {
    return _fetchProductUseCase.fetchProductListByQuery(
        businessId: businessId, query: query);
  }

  @override
  Future<ProductListEntity> fetchProductListByRecentSearches({required String businessId}) async {
    final productIds = await _fetchLocalStorageUseCase.fetchRecentProductSearches(businessId: businessId);
    return _fetchProductUseCase.fetchProductListByRecentSearches(
        productIds: productIds);
  }
}
