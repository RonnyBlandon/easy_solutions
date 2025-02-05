import 'package:easy_solutions/src/base/Constants/local_storage_keys.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Products/product_entity.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/LocalStorage/fetch_local_storage_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/LocalStorage/local_storage_use_case_parameters.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/User/ValidateCurrentUserUseCase/validate_current_user_use_case.dart';
import 'package:easy_solutions/src/features/presentation/business_list_page/View/business_list_page.dart';
import 'package:easy_solutions/src/features/presentation/product_categories_page/View/product_categories_page.dart';
import 'package:easy_solutions/src/features/presentation/product_details_page/View/product_details_page.dart';
import 'package:easy_solutions/src/features/presentation/restaurant_list_page/View/restaurant_list_page.dart';
import 'package:easy_solutions/src/features/presentation/restaurant_menu_page/View/restaurant_menu_page.dart';
import 'package:flutter/material.dart';

class RoutesPath {
  static String welcomePath = "welcome";
  static String tabsPath = "tabs";
}

class MainCoordinator {
  // Dependencias
  final FetchLocalStorageUseCase _fetchLocalStorageUseCase;
  final ValidateCurrentUserUseCase _validateCurrentUserUseCase;

  MainCoordinator(
      {FetchLocalStorageUseCase? fetchLocalStorageUseCase,
      ValidateCurrentUserUseCase? validateCurrentUserUseCase})
      : _fetchLocalStorageUseCase =
            fetchLocalStorageUseCase ?? DefaultFetchLocalStorageUseCase(),
        _validateCurrentUserUseCase =
            validateCurrentUserUseCase ?? DefaultValidateCurrentUserUseCase();

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
      return RestaurantMenuPage(businessId: businessId);
    }));
  }

  showProductDetailsPage(
      {required BuildContext context, required ProductDetailEntity product}) {
    Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) {
      return ProductDetailsPage(productDetailEntity: product);
    }));
  }

  showBusinessCategoriesPage({required BuildContext context}) {
    Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) {
      return const ProductCategoriesPage();
    }));
  }
}
