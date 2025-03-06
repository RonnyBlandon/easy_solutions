import 'package:easy_solutions/src/features/Domain/Entities/Business/business_list_entity.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Products/products_entity.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Favorites/favorites_use_case.dart';

abstract class FavoritesTabViewModelInput {
  Future<BusinessListEntity> fetchBusinessFavoritesList();
  Future<ProductListEntity> fetchProductFavoritesList();
}

// Crear ViewModel
abstract class FavoritesTabViewModel extends FavoritesTabViewModelInput {}

class DefaultFavoritesTabViewModel extends FavoritesTabViewModel {
  //Dependencias
  final FavoriteUseCase _favoriteUseCase;

  DefaultFavoritesTabViewModel({FavoriteUseCase? favoriteUseCase})
      : _favoriteUseCase = favoriteUseCase ?? DefaultFavoriteUseCase();
      
  @override
  Future<BusinessListEntity> fetchBusinessFavoritesList() async {
    return await _favoriteUseCase.fetchBusinessFavoritesList();
  }

  @override
  Future<ProductListEntity> fetchProductFavoritesList() async {
    return await _favoriteUseCase.fetchProductFavoritesList();
  }
}