import 'package:easy_solutions/src/features/Domain/Entities/Categories/categories_entity.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Categories/categories_use_case.dart';

enum BusinessCategoryViewModelState { viewLoadedState, errorState }

abstract class BusinessCategoryViewModelInput {
  Future<BusinessCategoryViewModelState> viewInitState(
      {required int businessCategoryId});
  late BusinessCategoryEntity businessCategory;
}

// Crear ViewModel
abstract class BusinessCategoryViewModel
    extends BusinessCategoryViewModelInput {}

class DefaultBusinessCategoryViewModel extends BusinessCategoryViewModel {
  final FetchCategoryUseCase _fetchCategoryUseCase;

  DefaultBusinessCategoryViewModel({FetchCategoryUseCase? fetchCategoryUseCase})
      : _fetchCategoryUseCase =
            fetchCategoryUseCase ?? DefaultFetchCategoryUseCase();

  @override
  Future<BusinessCategoryViewModelState> viewInitState(
      {required int businessCategoryId}) async {
    final businessCategoryResult = await _fetchCategoryUseCase
        .fetchCategoryUseCase(businessCategoryId: businessCategoryId);

    businessCategory = businessCategoryResult;
    if (businessCategory.id == businessCategoryId) {
      return BusinessCategoryViewModelState.viewLoadedState;
    } else {
      return BusinessCategoryViewModelState.errorState;
    }
  }
}
