import 'package:easy_solutions/src/features/Domain/Entities/Cart/cart_entity.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Cart/cart_use_case.dart';

enum CartsListViewModelState { viewLoadedState, errorState }

abstract class CartsListViewModelInput {
  Future<CartsListViewModelState> viewInitState({required String userId});
  List<CartEntity> cartsList = [];
}

// Crear ViewModel
abstract class CartsListViewModel extends CartsListViewModelInput {}

class DefaultCartsListViewModel extends CartsListViewModel {
  final CartsUseCase _cartsUseCase;

  DefaultCartsListViewModel({CartsUseCase? cartUseCase})
      : _cartsUseCase = cartUseCase ?? DefaultCartUseCase();

  @override
  Future<CartsListViewModelState> viewInitState(
      {required String userId}) async {
    final restaurantListResult =
        await _cartsUseCase.fetchCartsListUseCase(userId: userId);
    if (restaurantListResult.carts == null) {
      throw Exception("Lista de carritos no válida.");
    }

    cartsList = restaurantListResult.carts ?? [];
    if (cartsList.isNotEmpty) {
      return CartsListViewModelState.viewLoadedState;
    } else {
      return CartsListViewModelState.errorState;
    }
  }
}
