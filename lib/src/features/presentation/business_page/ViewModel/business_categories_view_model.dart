import 'package:easy_solutions/src/features/Domain/Entities/Business/business_list_entity.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Categories/categories_entity.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Categories/categories_use_case.dart';

enum BusinessCategoriesViewModelState { viewLoadedState, errorState }

abstract class BusinessCategoriesViewModelInput {
  Future<BusinessCategoriesViewModelState> viewInitState(
      {required String businessId});
  late BusinessDetailEntity businessDetail;
  List<BusinessCategoryEntity> businessCategoryList = [];
}

// Crear ViewModel
abstract class BusinessCategoriesViewModel
    extends BusinessCategoriesViewModelInput {}

class DefaultBusinessCategoriesViewModel extends BusinessCategoriesViewModel {
  //Dependencias
  final FetchCategoryUseCase _categoriesUseCase;

  DefaultBusinessCategoriesViewModel({FetchCategoryUseCase? categoriesUseCase})
      : _categoriesUseCase = categoriesUseCase ?? DefaultFetchCategoryUseCase();

  @override
  Future<BusinessCategoriesViewModelState> viewInitState(
      {required String businessId}) async {
    final businessCategoryListResult = await _categoriesUseCase
        .fetchBusinessCategoriestUseCase(businessId: businessId);
    if (businessCategoryListResult.businessCategories == null) {
      throw Exception("Lista de categorias del negocio no válida");
    }
    businessCategoryList = businessCategoryListResult.businessCategories ?? [];
    businessDetail = businessCategoryListResult.business;
    if (businessCategoryList.isNotEmpty) {
      return BusinessCategoriesViewModelState.viewLoadedState;
    } else {
      return BusinessCategoriesViewModelState.errorState;
    }
  }
}
