import 'package:easy_solutions/src/features/Domain/Entities/Categories/categories_entity.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/data/Repositories/Categories/categories_repository.dart';

abstract class FetchCategoryUseCase {
  Future<BusinessCategoryListEntity> execute({required String businessId});
}

class DefaultFetchCategoryUseCase extends FetchCategoryUseCase {
  //Dependencias
  final CategoriesRepository _categoriesRepository;

  DefaultFetchCategoryUseCase({CategoriesRepository? categoriesRepository})
      : _categoriesRepository =
            categoriesRepository ?? DefaultCategoriesRepository();

  @override
  Future<BusinessCategoryListEntity> execute(
      {required String businessId}) async {
    final decodable =
        await _categoriesRepository.fetchCategories(businessId: businessId);
    return BusinessCategoryListEntity.fromMap(decodable.toMap());
  }
}
