import 'package:easy_solutions/src/features/Domain/Entities/Business/business_list_entity.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Business/BusinessList/business_list_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Categories/categories_use_case.dart';

enum BusinessListViewModelState { viewLoadedState, errorState }

abstract class BusinessListViewModelInput {
  Future<BusinessListViewModelState> viewInitState(
      {required int typeBusinessId});
  List<BusinessDetailEntity> businessList = [];
}

// Crear ViewModel
abstract class BusinessListViewModel extends BusinessListViewModelInput {}

class DefaultBusinessListViewModel extends BusinessListViewModel {
  final BusinessListUseCase _businessListUseCase;

  DefaultBusinessListViewModel(
      {BusinessListUseCase? businessListUseCase,
      FetchCategoryUseCase? fetchCategoryUseCase})
      : _businessListUseCase =
            businessListUseCase ?? DefaultBusinessListUseCase();

  @override
  Future<BusinessListViewModelState> viewInitState(
      {required int typeBusinessId}) async {
    final businessListResult = await _businessListUseCase
        .fetchBusinessListByTypeBusiness(typeBusinessId: typeBusinessId);
    if (businessListResult.businessList == null) {
      throw Exception("Lista de negocios no válida.");
    }

    businessList = businessListResult.businessList ?? [];
    if (businessList.isNotEmpty) {
      return BusinessListViewModelState.viewLoadedState;
    } else {
      return BusinessListViewModelState.errorState;
    }
  }
}
