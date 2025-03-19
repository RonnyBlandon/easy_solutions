import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/base/Constants/error_messages.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Business/business_list_entity.dart';
import 'package:easy_solutions/src/features/Domain/Entities/PaymentMethods/payment_methods_entity.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Products/products_entity.dart';
import 'package:easy_solutions/src/features/Domain/Entities/User/user_entity.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Favorites/favorites_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/PaymentMethods/payment_methods_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/User/FetchUserDataUseCase/fetch_user_data_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/User/SaveUserDataUseCase/save_user_data_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/User/SaveUserDataUseCase/save_user_data_use_case_parameters.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/cards/favorites_cards/favorite_business_card_view.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/cards/favorites_cards/favorite_product_card_view.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin FavouritePageChangeStateDelegate {
  businessFromFavouritesRemoved();
  productFromFavouritesRemoved();
}

class DefaultUserStateProvider extends ChangeNotifier
    with FavouriteBusinessCardViewDelegate, FavouriteProductCardViewDelegate {
  // Exposed Properties
  UserEntity? userData;

  // Dependencias
  final FetchUserDataUseCase _fetchUserDataUseCase;
  final FavoriteUseCase _favoriteUseCase;
  final SaveUserDataUseCase _saveUserDataUseCase;
  final PaymentMethodsUseCase _paymentMethodsUseCase;

  // Delegates
  FavouritePageChangeStateDelegate? favouritePageChangeStateDelegate;

  DefaultUserStateProvider({
    FetchUserDataUseCase? fetchUserDataUseCase,
    FavoriteUseCase? favoriteUseCase,
    SaveUserDataUseCase? saveUserDataUseCase,
    PaymentMethodsUseCase? paymentMethodsUseCase,
  }) : _fetchUserDataUseCase =
           fetchUserDataUseCase ?? DefaultFetchUserDataUseCase(),
       _favoriteUseCase = favoriteUseCase ?? DefaultFavoriteUseCase(),
       _saveUserDataUseCase =
           saveUserDataUseCase ?? DefaultSaveUserDataUseCase(),
       _paymentMethodsUseCase =
           paymentMethodsUseCase ?? DefaultPaymentMethodsUseCase();

  @override
  favouriteBusinessIconTapped(bool isTapped, String businessId) async {
    await _favoriteUseCase.saveOrRemoveUserFromBusinessFavourites(
      businessId: businessId,
      isFavorite: isTapped,
    );
    if (!isTapped) {
      favouritePageChangeStateDelegate?.businessFromFavouritesRemoved();
    }
  }

  @override
  favouriteProductIconTapped(bool isTapped, String productId) async {
    await _favoriteUseCase.saveOrRemoveUserFromProductFavourites(
      productId: productId,
      isFavorite: isTapped,
    );
    if (!isTapped) {
      favouritePageChangeStateDelegate?.productFromFavouritesRemoved();
    }
  }
}

// UserData
extension UserData on DefaultUserStateProvider {
  fetchUserData() async {
    userData = await _fetchUserDataUseCase.execute();
  }

  Future<UserEntity> updateUserData({required UserEntity user}) async {
    return _saveUserDataUseCase
        .execute(parameters: SaveUserDataUseCaseParameters.fromUserEntity(user))
        .then((result) {
          switch (result.status) {
            case ResultStatus.success:
              if (result.value == null) {
                return Future.error(AppFailureMessages.unExpectedErrorMessage);
              }
              userData = result.value;
              return result.value!;
            case ResultStatus.error:
              return Future.error(AppFailureMessages.unExpectedErrorMessage);
          }
        });
  }
}

// Favourites
extension Favorites on DefaultUserStateProvider {
  Future<List<BusinessDetailEntity>> fetchUserFavouriteBusinessList() async {
    BusinessListEntity businessList =
        await _favoriteUseCase.fetchBusinessFavoritesList();
    return businessList.businessList ?? [];
  }

  Future<List<ProductDetailEntity>> fetchUserFavouriteProductList() async {
    ProductListEntity productList =
        await _favoriteUseCase.fetchProductFavoritesList();
    return productList.productList ?? [];
  }
}

// PaymentMethods
extension PaymentMethods on DefaultUserStateProvider {
  Future<PaymentMethodListEntity?> getPaymentMethods() async {
    return _paymentMethodsUseCase.getPaymentMethods();
  }

  Future<PaymentMethodEntity?> addPaymentMethod({
    required PaymentMethodEntity paymentMethod,
  }) async {
    return _paymentMethodsUseCase.addPaymentMethod(parameters: paymentMethod);
  }

  Future<PaymentMethodEntity?> editPaymentMethod({
    required PaymentMethodEntity paymentMethod,
  }) async {
    if (paymentMethod.id.isNotEmpty) {
      return _paymentMethodsUseCase.updatePaymentMethod(
        parameters: paymentMethod,
      );
    } else {
      return Future.error(
        Failure.fromMessage(message: AppFailureMessages.unExpectedErrorMessage),
      );
    }
  }

  Future<bool> deletePaymentMethod({
    required PaymentMethodEntity paymentMethod,
  }) async {
    if (paymentMethod.id.isNotEmpty) {
      return _paymentMethodsUseCase.deletePaymentMethod(
        paymentMethodId: paymentMethod.id,
      );
    }

    return Future.error(
      Failure.fromMessage(message: AppFailureMessages.unExpectedErrorMessage),
    );
  }

  Future<PaymentMethodEntity?> selectMainPaymentMethod({
    required PaymentMethodEntity paymentMethod,
  }) async {
    if (paymentMethod.id.isNotEmpty) {
      paymentMethod.isMainPaymentMethod = true;
      return _paymentMethodsUseCase.updatePaymentMethod(
        parameters: paymentMethod,
      );
    }

    return Future.error(
      Failure.fromMessage(message: AppFailureMessages.unExpectedErrorMessage),
    );
  }
}

// BuildContext
extension DefaultUserStateProviderExtension on BuildContext {
  // Provider
  DefaultUserStateProvider getDefaultUserStateProvider() =>
      Provider.of<DefaultUserStateProvider>(this);
  // UserData
  UserEntity? getUserData() =>
      Provider.of<DefaultUserStateProvider>(this, listen: false).userData;
  // Favourites
  Future<List<BusinessDetailEntity>> fetchUserFavouriteBusinessList() =>
      Provider.of<DefaultUserStateProvider>(
        this,
        listen: false,
      ).fetchUserFavouriteBusinessList();
  Future<List<ProductDetailEntity>> fetchUserFavouriteProductList() =>
      Provider.of<DefaultUserStateProvider>(
        this,
        listen: false,
      ).fetchUserFavouriteProductList();
  Future<void> favouriteBusinessIconTapped(bool isTapped, String businessId) =>
      Provider.of<DefaultUserStateProvider>(
        this,
        listen: false,
      ).favouriteBusinessIconTapped(isTapped, businessId);
  Future<void> favouriteProductIconTapped(bool isTapped, String productId) =>
      Provider.of<DefaultUserStateProvider>(
        this,
        listen: false,
      ).favouriteProductIconTapped(isTapped, productId);

  // PaymentMethods
  Future<PaymentMethodListEntity?> getPaymentMethods() =>
      Provider.of<DefaultUserStateProvider>(this).getPaymentMethods();
  Future<PaymentMethodEntity?> addPaymentMethod({
    required PaymentMethodEntity paymentMethod,
  }) => Provider.of<DefaultUserStateProvider>(
    this,
    listen: false,
  ).addPaymentMethod(paymentMethod: paymentMethod);
  Future<PaymentMethodEntity?> editPaymentMethod({
    required PaymentMethodEntity paymentMethod,
  }) => Provider.of<DefaultUserStateProvider>(
    this,
    listen: false,
  ).editPaymentMethod(paymentMethod: paymentMethod);
  Future<bool> deletePaymentMethod({
    required PaymentMethodEntity paymentMethod,
  }) => Provider.of<DefaultUserStateProvider>(
    this,
    listen: false,
  ).deletePaymentMethod(paymentMethod: paymentMethod);
  Future<PaymentMethodEntity?> selectMainPaymentMethod({
    required PaymentMethodEntity paymentMethod,
  }) => Provider.of<DefaultUserStateProvider>(
    this,
    listen: false,
  ).selectMainPaymentMethod(paymentMethod: paymentMethod);
}
