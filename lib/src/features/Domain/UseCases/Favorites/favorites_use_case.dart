import 'package:easy_solutions/src/base/Constants/error_messages.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Business/business_list_entity.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Products/products_entity.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/data/Repositories/Favorites/favorites_repository.dart';

abstract class FavoriteUseCase {
  Future<BusinessListEntity> fetchBusinessFavoritesList();
  Future<ProductListEntity> fetchProductFavoritesList();
  Future<void> saveOrRemoveUserFromProductFavourites({required String productId, required bool isFavorite});
  Future<void> addUserBusinessInFavorites({required String businessId});
  Future<void> removeUserBusinessInFavorites({required String businessId});
  Future<void> saveOrRemoveUserFromBusinessFavourites({required String businessId, required bool isFavorite});
  Future<void> addUserProductInFavorites({required String productId});
  Future<void> removeUserProductInFavorites({required String productId});
}

class DefaultFavoriteUseCase extends FavoriteUseCase {
  //Dependencias
  final FavoriteRepository _favoriteRepository;

  DefaultFavoriteUseCase({FavoriteRepository? favoriteRepository})
      : _favoriteRepository = favoriteRepository ?? DefaultFavoriteRepository();

  @override
  Future<BusinessListEntity> fetchBusinessFavoritesList() async {
    final decodable = await _favoriteRepository.fetchBuisnessFavoritesList();
    return BusinessListEntity.fromMap(decodable.toMap());
  }

  @override
  Future<ProductListEntity> fetchProductFavoritesList() async {
    final decodable = await _favoriteRepository.fetchProductFavoritesList();
    return ProductListEntity.fromMap(decodable.toMap());
  }

  @override
  Future<void> saveOrRemoveUserFromBusinessFavourites({required String businessId, required bool isFavorite}) {
    if (isFavorite) {
      return addUserBusinessInFavorites(businessId: businessId);
    } else {
      return removeUserBusinessInFavorites(businessId: businessId);
    }
  }

  @override
  Future<void> addUserBusinessInFavorites({required String businessId}) async {
    bool isAdd = await _favoriteRepository.addBusinessFavorite(businessId: businessId);
    if (isAdd == false) {
      return Future.error(AppFailureMessages.unExpectedErrorMessage);
    }
  }

  @override
  Future<void> removeUserBusinessInFavorites({required String businessId}) async {
    bool isRemove = await _favoriteRepository.removeBusinessFavorite(businessId: businessId);
    if (isRemove == false) {
      return Future.error(AppFailureMessages.unExpectedErrorMessage);
    }
  }

  @override
  Future<void> saveOrRemoveUserFromProductFavourites({required String productId, required bool isFavorite}) {
    if (isFavorite) {
      return addUserProductInFavorites(productId: productId);
    } else {
      return removeUserProductInFavorites(productId: productId);
    }
  }

  @override
  Future<void> addUserProductInFavorites({required String productId}) async {
    bool isAdd = await _favoriteRepository.addProductFavorite(productId: productId);
    if (isAdd == false) {
      return Future.error(AppFailureMessages.unExpectedErrorMessage);
    }
  }

  @override
  Future<void> removeUserProductInFavorites({required String productId}) async {
    bool isRemove = await _favoriteRepository.removeProductFavorite(productId: productId);
    if (isRemove == false) {
      return Future.error(AppFailureMessages.unExpectedErrorMessage);
    }
  }
}