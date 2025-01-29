import 'package:easy_solutions/src/features/Domain/Entities/Business/business_list_entity.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Business/BusinessList/business_list_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Categories/categories_use_case.dart';

enum RestaurantListViewModelState { viewLoadedState, errorState }

abstract class RestaurantViewModelInput {
  Future<RestaurantListViewModelState> viewInitState();
  List<BusinessDetailEntity> restaurantList = [];
}

// Crear ViewModel
abstract class RestaurantListViewModel extends RestaurantViewModelInput {}

class DefaultRestaurantListViewModel extends RestaurantListViewModel {
  final BusinessListUseCase _businessListUseCase;

  DefaultRestaurantListViewModel(
      {BusinessListUseCase? businessListUseCase,
      FetchCategoryUseCase? fetchCategoryUseCase})
      : _businessListUseCase =
            businessListUseCase ?? DefaultBusinessListUseCase();

  @override
  Future<RestaurantListViewModelState> viewInitState() async {
    final restaurantListResult = await _businessListUseCase
        .fetchBusinessListByTypeBusiness(typeBusinessId: 1);
    if (restaurantListResult.businessList == null) {
      throw Exception("Lista de restaurantes no válida.");
    }

    restaurantList = restaurantListResult.businessList ?? [];
    print("Esto contiene restaurantList en viewInitState: $restaurantList");
    if (restaurantList.isNotEmpty) {
      return RestaurantListViewModelState.viewLoadedState;
    } else {
      return RestaurantListViewModelState.errorState;
    }
  }
}
