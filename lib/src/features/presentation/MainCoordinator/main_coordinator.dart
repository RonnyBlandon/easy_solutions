import 'package:easy_solutions/src/base/Constants/local_storage_keys.dart';
import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/Domain/Entities/PaymentMethods/payment_methods_entity.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Products/products_entity.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/LocalStorage/fetch_local_storage_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/LocalStorage/local_storage_use_case_parameters.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/LocalStorage/save_local_storage_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/User/ValidateCurrentUserUseCase/validate_current_user_use_case.dart';
import 'package:easy_solutions/src/features/presentation/business_category_page/View/business_category_page.dart';
import 'package:easy_solutions/src/features/presentation/business_list_page/View/business_list_page.dart';
import 'package:easy_solutions/src/features/presentation/business_page/View/business_page.dart';
import 'package:easy_solutions/src/features/presentation/business_product_page%20copy/View/business_product_page.dart';
import 'package:easy_solutions/src/features/presentation/carts_list_page/View/carts_list_page.dart';
import 'package:easy_solutions/src/features/presentation/edit_add_card_credit_page/View/edit_add_card_credit.dart';
import 'package:easy_solutions/src/features/presentation/payment_methods_page/View/payment_methods_page.dart';
import 'package:easy_solutions/src/features/presentation/restaurant_product_page/View/restaurant_product_page.dart';
import 'package:easy_solutions/src/features/presentation/restaurant_list_page/View/restaurant_list_page.dart';
import 'package:easy_solutions/src/features/presentation/restaurant_page/View/restaurant_page.dart';
import 'package:flutter/material.dart';

class RoutesPath {
  static String welcomePath = "welcome";
  static String tabsPath = "tabs";
}

class MainCoordinator {
  // Dependencias
  final FetchLocalStorageUseCase _fetchLocalStorageUseCase;
  final ValidateCurrentUserUseCase _validateCurrentUserUseCase;
  final SaveLocalStorageUseCase _saveLocalStorageUseCase;

  String? userId;
  static MainCoordinator? sharedInstance = MainCoordinator();

  MainCoordinator({
    FetchLocalStorageUseCase? fetchLocalStorageUseCase,
    ValidateCurrentUserUseCase? validateCurrentUserUseCase,
    SaveLocalStorageUseCase? saveLocalStorageUseCase,
  }) : _fetchLocalStorageUseCase =
           fetchLocalStorageUseCase ?? DefaultFetchLocalStorageUseCase(),
       _validateCurrentUserUseCase =
           validateCurrentUserUseCase ?? DefaultValidateCurrentUserUseCase(),
       _saveLocalStorageUseCase =
           saveLocalStorageUseCase ?? DefaultSaveLocalStorageUseCase();

  Future<String?> start() {
    return _isUserLogged().then((value) {
      return value == null ? RoutesPath.welcomePath : RoutesPath.tabsPath;
    });
  }

  Future<String?> _isUserLogged() async {
    var accessToken = await _fetchLocalStorageUseCase.execute(
      parameters: FetchLocalStorageParameters(
        key: LocalStorageKeys.accessToken,
      ),
    );
    userId = await _fetchLocalStorageUseCase.execute(
      parameters: FetchLocalStorageParameters(key: LocalStorageKeys.localId),
    );
    return accessToken;
  }

  showTabsPage({required BuildContext context}) {
    Navigator.pushNamed(context, RoutesPath.tabsPath);
  }

  showRestaurantOrBusinessListPage({
    required BuildContext context,
    required int typeBusinessId,
  }) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) {
          if (typeBusinessId == 1) {
            // 1 es el id de los tipo de restaurante asi debe de estar en la base de datos en el server
            return RestaurantListPage(typeBusinessId: typeBusinessId);
          } else {
            return BusinessListPage(typeBusinessId: typeBusinessId);
          }
        },
      ),
    );
  }

  showRestaurantCategoriesPage({
    required BuildContext context,
    required String businessId,
  }) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) {
          return RestaurantPage(businessId: businessId);
        },
      ),
    );
  }

  showRestaurantProductPage({
    required BuildContext context,
    required ProductDetailEntity product,
  }) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) {
          return RestaurantProductPage(productDetailEntity: product);
        },
      ),
    );
  }

  showBusinessCategoriesPage({
    required BuildContext context,
    required String businessId,
  }) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) {
          return BusinessPage(businessId: businessId);
        },
      ),
    );
  }

  showBusinessCategoryPage({
    required BuildContext context,
    required int businessCategoryId,
    required String businessId,
  }) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) {
          return BusinessCategoryPage(
            businessCategoryId: businessCategoryId,
            businessId: businessId,
          );
        },
      ),
    );
  }

  showBusinessProductPage({
    required BuildContext context,
    required ProductDetailEntity product,
  }) async {
    await _saveLocalStorageUseCase.saveRecentProductSearchInLocalStorage(
      businessId: product.businessId,
      productId: product.id,
    );
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) {
          return BusinessProductPage(productDetailEntity: product);
        },
      ),
    );
  }

  showCartsListPage({required BuildContext context, required String userId}) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) {
          return CartsListPage(userId: userId);
        },
      ),
    );
  }

  showEditPasswordPage({required BuildContext context}) {
    Navigator.pushNamed(context, 'edit_password');
  }

  showPaymentMethodsPage({required BuildContext context}) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) {
          return PaymentMethodsPage();
        },
      ),
    );
  }

  showAddEditCardPage({
    required BuildContext context,
    bool? isForEditing,
    PaymentMethodEntity? paymentMethod,
    BaseViewStateDelegate? viewStateDelegate,
  }) {
    pushPage(
      context: context,
      page: AddEditCardPage(
        isEditing: isForEditing,
        paymentMethod: paymentMethod,
        viewStateDelegate: viewStateDelegate,
      ),
    );
  }

  pushPage({required BuildContext context, required Widget page}) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }
}
