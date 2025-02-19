import 'package:easy_solutions/src/features/Domain/Entities/Business/business_list_entity.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Business/BusinessList/business_list_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Categories/categories_use_case.dart';

enum ExploreTabViewModelState { viewLoadedState, errorState }

abstract class ExploreTabViewModelInput {
  Future<ExploreTabViewModelState> viewInitState();
  List<TypeBusinessDetailEntity> typeBusinessList = [];
}

// Crear ViewModel
abstract class ExploreTabViewModel extends ExploreTabViewModelInput {}

class DefaultExploreTabViewModel extends ExploreTabViewModel {
  final BusinessListUseCase _businessListUseCase;

  DefaultExploreTabViewModel(
      {BusinessListUseCase? businessListUseCase,
      FetchCategoryUseCase? fetchCategoryUseCase})
      : _businessListUseCase =
            businessListUseCase ?? DefaultBusinessListUseCase();

  @override
  Future<ExploreTabViewModelState> viewInitState() async {
    final restaurantListResult =
        await _businessListUseCase.fetchTypeBusinessList();
    if (restaurantListResult.typeBusinessList == null) {
      throw Exception("Lista de restaurantes no válida.");
    }

    typeBusinessList = restaurantListResult.typeBusinessList ?? [];
    if (typeBusinessList.isNotEmpty) {
      return ExploreTabViewModelState.viewLoadedState;
    } else {
      return ExploreTabViewModelState.errorState;
    }
  }
}
