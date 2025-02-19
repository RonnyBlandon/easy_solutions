import 'package:easy_solutions/src/features/Domain/Entities/Categories/categories_entity.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/data/Repositories/Categories/categories_repository.dart';

abstract class FetchCategoryUseCase {
  Future<BusinessCategoryListEntity> fetchRestaurantCategoriestUseCase(
      {required String businessId});
  Future<BusinessCategoryListEntity> fetchBusinessCategoriestUseCase(
      {required String businessId});
  Future<BusinessCategoryEntity> fetchCategoryUseCase(
      {required int businessCategoryId});
}

class DefaultFetchCategoryUseCase extends FetchCategoryUseCase {
  //Dependencias
  final CategoriesRepository _categoriesRepository;

  DefaultFetchCategoryUseCase({CategoriesRepository? categoriesRepository})
      : _categoriesRepository =
            categoriesRepository ?? DefaultCategoriesRepository();

  @override
  Future<BusinessCategoryListEntity> fetchRestaurantCategoriestUseCase(
      {required String businessId}) async {
    final decodable = await _categoriesRepository.fetchRestaurantCategories(
        businessId: businessId);
    return BusinessCategoryListEntity.fromMap(decodable.toMap())
        .filterCategoriesByProductList();
  }

  @override
  Future<BusinessCategoryListEntity> fetchBusinessCategoriestUseCase(
      {required String businessId}) async {
    final decodable = await _categoriesRepository.fetchBusinessCategories(
        businessId: businessId);
    return BusinessCategoryListEntity.fromMap(decodable.toMap())
        .filterCategoriesByProductList();
  }

  @override
  Future<BusinessCategoryEntity> fetchCategoryUseCase(
      {required int businessCategoryId}) async {
    final decodable = await _categoriesRepository.fetchCategory(
        businessCategoryId: businessCategoryId);
    return BusinessCategoryEntity.fromMap(decodable.toMap());
  }
}
