import 'package:easy_solutions/src/base/Constants/local_storage_keys.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Products/product_entity.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/LocalStorage/fetch_local_storage_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/LocalStorage/local_storage_use_case_parameters.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/LocalStorage/save_local_storage_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/User/ValidateCurrentUserUseCase/validate_current_user_use_case.dart';
import 'package:easy_solutions/src/features/presentation/business_category_page/View/business_category_page.dart';
import 'package:easy_solutions/src/features/presentation/business_list_page/View/business_list_page.dart';
import 'package:easy_solutions/src/features/presentation/business_page/View/business_page.dart';
import 'package:easy_solutions/src/features/presentation/business_product_page%20copy/View/business_product_page.dart';
import 'package:easy_solutions/src/features/presentation/carts_list_page/View/carts_list_page.dart';
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

  MainCoordinator(
      {FetchLocalStorageUseCase? fetchLocalStorageUseCase,
      ValidateCurrentUserUseCase? validateCurrentUserUseCase, 
      SaveLocalStorageUseCase? saveLocalStorageUseCase})
      : _fetchLocalStorageUseCase =
            fetchLocalStorageUseCase ?? DefaultFetchLocalStorageUseCase(),
        _validateCurrentUserUseCase =
            validateCurrentUserUseCase ?? DefaultValidateCurrentUserUseCase(),
        _saveLocalStorageUseCase = saveLocalStorageUseCase ?? DefaultSaveLocalStorageUseCase();

  Future<String?> start() {
    return _isUserLogged().then((value) {
      return value == null ? RoutesPath.welcomePath : RoutesPath.tabsPath;
    });
  }

  Future<String?> _isUserLogged() async {
    var accessToken = await _fetchLocalStorageUseCase.execute(
        parameters:
            FetchLocalStorageParameters(key: LocalStorageKeys.accessToken));

    return accessToken;
  }

  showTabsPage({required BuildContext context}) {
    Navigator.pushNamed(context, RoutesPath.tabsPath);
  }

  showRestaurantOrBusinessListPage(
      {required BuildContext context, required int typeBusinessId}) {
    Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) {
      if (typeBusinessId == 1) {
        // 1 es el id de los tipo de restaurante asi debe de estar en la base de datos en el server
        return RestaurantListPage(typeBusinessId: typeBusinessId);
      } else {
        return BusinessListPage(typeBusinessId: typeBusinessId);
      }
    }));
  }

  showRestaurantCategoriesPage(
      {required BuildContext context, required String businessId}) {
    Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) {
      return RestaurantPage(businessId: businessId);
    }));
  }

  showRestaurantProductPage(
      {required BuildContext context, required ProductDetailEntity product}) {
    Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) {
      return RestaurantProductPage(productDetailEntity: product);
    }));
  }

  showBusinessCategoriesPage(
      {required BuildContext context, required String businessId}) {
    Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) {
      return BusinessPage(businessId: businessId);
    }));
  }

  showBusinessCategoryPage(
      {required BuildContext context,
      required int businessCategoryId,
      required String businessId}) {
    Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) {
      return BusinessCategoryPage(
          businessCategoryId: businessCategoryId, businessId: businessId);
    }));
  }

  showBusinessProductPage(
      {required BuildContext context, required ProductDetailEntity product}) async {
    await _saveLocalStorageUseCase.saveRecentProductSearchInLocalStorage(businessId: product.businessId, productId: product.id);
    Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) {
      return BusinessProductPage(productDetailEntity: product);
    }));
  }

  showCartsListPage({required BuildContext context, required String userId}) {
    Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) {
      return CartsListPage(userId: userId);
    }));
  }
}
