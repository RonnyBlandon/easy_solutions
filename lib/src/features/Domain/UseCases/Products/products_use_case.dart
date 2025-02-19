import 'package:easy_solutions/src/features/Domain/Entities/Products/product_entity.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/data/Repositories/Products/products_repository.dart';

abstract class FetchProductUseCase {
  Future<ProductListEntity> fetchProductListByQuery(
      {required String businessId, required String query});
  Future<ProductListEntity> fetchProductListByRecentSearches(
      {required List<String> productIds});
}

class DefaultFetchProductUseCase extends FetchProductUseCase {
  //Dependencias
  final ProductRepository _productRepository;

  DefaultFetchProductUseCase({ProductRepository? productRepository})
      : _productRepository = productRepository ?? DefaultProductRepository();

  @override
  Future<ProductListEntity> fetchProductListByQuery(
      {required String businessId, required String query}) async {
    final decodable = await _productRepository.fetchProductListByQuery(
        businessId: businessId, query: query);
    return ProductListEntity.fromMap(decodable.toMap());
  }

  @override
  Future<ProductListEntity> fetchProductListByRecentSearches(
      {required List<String> productIds}) async {
    final decodable = await _productRepository.fetchProductListByRecentSearches(
        productIds: productIds);
    return ProductListEntity.fromMap(decodable.toMap());
  }
}
