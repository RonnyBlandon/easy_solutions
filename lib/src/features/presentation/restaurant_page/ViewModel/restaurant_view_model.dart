import 'package:easy_solutions/src/features/Domain/Entities/Business/business_list_entity.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Categories/categories_entity.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Categories/categories_use_case.dart';

enum RestaurantViewModelState { viewLoadedState, errorState }

abstract class RestaurantViewModelInput {
  Future<RestaurantViewModelState> viewInitState({required String businessId});
  late BusinessDetailEntity businessDetail;
  List<BusinessCategoryEntity> businessCategoryList = [];
}

// Crear ViewModel
abstract class RestaurantViewModel extends RestaurantViewModelInput {}

class DefaultRestaurantViewModel extends RestaurantViewModel {
  //Dependencias
  final FetchCategoryUseCase _categoriesUseCase;

  DefaultRestaurantViewModel({FetchCategoryUseCase? categoriesUseCase})
      : _categoriesUseCase = categoriesUseCase ?? DefaultFetchCategoryUseCase();

  @override
  Future<RestaurantViewModelState> viewInitState(
      {required String businessId}) async {
    final restaurantCategoryListResult = await _categoriesUseCase
        .fetchRestaurantCategoriestUseCase(businessId: businessId);
    if (restaurantCategoryListResult.businessCategories == null) {
      throw Exception("Lista de categorias del restaurante no válida");
    }
    businessCategoryList =
        restaurantCategoryListResult.businessCategories ?? [];
    businessDetail = restaurantCategoryListResult.business;
    if (businessCategoryList.isNotEmpty) {
      return RestaurantViewModelState.viewLoadedState;
    } else {
      return RestaurantViewModelState.errorState;
    }
  }
}
