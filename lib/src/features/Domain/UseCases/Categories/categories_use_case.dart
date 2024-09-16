import 'package:easy_solutions/src/features/Domain/Entities/Categories/category_entity.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/data/Repositories/Categories/categories_repository.dart';

abstract class FetchCategoryUseCase {
  Future<CategoriesEntity> execute();
}

class DefaultFetchCategoryUseCase extends FetchCategoryUseCase {
  //Dependencias
  final CategoriesRepository _categoriesRepository;

  DefaultFetchCategoryUseCase({CategoriesRepository? categoriesRepository})
      : _categoriesRepository =
            categoriesRepository ?? DefaultCategoriesRepository();

  @override
  Future<CategoriesEntity> execute() async {
    final decodable = await _categoriesRepository.fetchCategories();
    return CategoriesEntity.fromMap(decodable.toMap());
  }
}
