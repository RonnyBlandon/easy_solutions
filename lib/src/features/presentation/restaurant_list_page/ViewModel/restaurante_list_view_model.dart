import 'package:easy_solutions/src/features/Domain/Entities/Business/business_list_entity.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Business/BusinessList/business_list_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Categories/categories_use_case.dart';

enum RestaurantListViewModelState { viewLoadedState, errorState }

abstract class RestaurantListViewModelInput {
  Future<RestaurantListViewModelState> viewInitState(
      {required int typeBusinessId});
  List<BusinessDetailEntity> restaurantList = [];
}

// Crear ViewModel
abstract class RestaurantListViewModel extends RestaurantListViewModelInput {}

class DefaultRestaurantListViewModel extends RestaurantListViewModel {
  final BusinessListUseCase _businessListUseCase;

  DefaultRestaurantListViewModel(
      {BusinessListUseCase? businessListUseCase,
      FetchCategoryUseCase? fetchCategoryUseCase})
      : _businessListUseCase =
            businessListUseCase ?? DefaultBusinessListUseCase();

  @override
  Future<RestaurantListViewModelState> viewInitState(
      {required int typeBusinessId}) async {
    final restaurantListResult = await _businessListUseCase
        .fetchBusinessListByTypeBusiness(typeBusinessId: typeBusinessId);
    if (restaurantListResult.businessList == null) {
      throw Exception("Lista de restaurantes no válida.");
    }

    restaurantList = restaurantListResult.businessList ?? [];
    if (restaurantList.isNotEmpty) {
      return RestaurantListViewModelState.viewLoadedState;
    } else {
      return RestaurantListViewModelState.errorState;
    }
  }
}
