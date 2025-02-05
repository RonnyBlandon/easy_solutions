import 'package:easy_solutions/src/features/Domain/Entities/Business/business_list_entity.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Categories/categories_entity.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Categories/categories_use_case.dart';

enum RestaurantMenuViewModelState { viewLoadedState, errorState }

abstract class RestaurantMenuViewModelInput {
  Future<RestaurantMenuViewModelState> viewInitState(
      {required String businessId});
  late BusinessDetailEntity businessDetail;
  List<BusinessCategoryEntity> businessCategoryList = [];
}

// Crear ViewModel
abstract class RestaurantMenuViewModel extends RestaurantMenuViewModelInput {}

class DefaultRestaurantMenuViewModel extends RestaurantMenuViewModel {
  //Dependencias
  final FetchCategoryUseCase _categoriesUseCase;

  DefaultRestaurantMenuViewModel({FetchCategoryUseCase? categoriesUseCase})
      : _categoriesUseCase = categoriesUseCase ?? DefaultFetchCategoryUseCase();

  @override
  Future<RestaurantMenuViewModelState> viewInitState(
      {required String businessId}) async {
    final businessCategoryListResult =
        await _categoriesUseCase.execute(businessId: businessId);
    if (businessCategoryListResult.businessCategories == null) {
      throw Exception("Lista de categorias del restaurante no válida");
    }
    businessCategoryList = businessCategoryListResult.businessCategories ?? [];
    businessDetail = businessCategoryListResult.business;
    if (businessCategoryList.isNotEmpty) {
      return RestaurantMenuViewModelState.viewLoadedState;
    } else {
      return RestaurantMenuViewModelState.errorState;
    }
  }
}
