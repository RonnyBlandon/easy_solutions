import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/features/data/Decodables/Auth/UserAuthData/user_auth_data_decodable.dart';
import 'package:easy_solutions/src/features/data/Decodables/CartDecodable/cart_decodable.dart';
import 'package:easy_solutions/src/features/data/Decodables/CategoriesDecodable/categories_decodable.dart';
import 'package:easy_solutions/src/features/data/Decodables/ProductDecodable/products_decodable.dart';
import 'package:easy_solutions/src/features/data/Decodables/User/user_decodable.dart';
import 'package:easy_solutions/src/features/data/Repositories/Auth/SignInRepository/signin_body_parameters.dart';
import 'package:easy_solutions/src/features/data/Repositories/Auth/UserAuthData/user_auth_data_repository_body_parameters.dart';
import 'package:easy_solutions/src/features/data/Repositories/User/user_body_parameters.dart';
import 'package:easy_solutions/src/managers/businessManager/Decodables/business_list_decodable.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/AuthEasyDeliveryServices/Decodables/reset_password_decodable.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/AuthEasyDeliveryServices/Decodables/sign_in_decodable.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';

//Auth Repositories
abstract class SignInRepository {
  Future<Result<SignInDecodable, Failure>> signIn(
      {required SignInBodyParameters params});
}

abstract class ResetPasswordRepository {
  Future<Result<ResetPasswordDecodable, Failure>> resetPassword(
      {required String email});
}

abstract class UserAuthDataRepository {
  Future<Result<UserAuthDataDecodable, Failure>> getUserAuthData(
      {required GetUserDataBodyParameters parameters});
}

// User Database Repositories
abstract class SaveUserDataRepository {
  Future<Result<UserDecodable, Failure>> saveUserData(
      {required UserBodyParameters parameters});
}

abstract class FetchUserDataRepository {
  Future<Result<UserDecodable, Failure>> fetchUserData(
      {required String localId});
}

// Local Storage
abstract class SaveLocalStorageRepository {
  Future<void> saveInLocalStorage({required String key, required String value});
  Future<void> saveRecentSearchInLocalStorage(
      {required String key, required List<String> value});
}

abstract class FetchLocalStorageRepository {
  Future<String?> fetchInLocalStorage({required String key});
  Future<List<String>?> fetchRecentProductSearches({required String businessId});
}

abstract class RemoveLocalStorageRepository {
  Future<void> removeLocalStorage({required String key});
}

// Business Repositories
abstract class BusinessDetailRepository {
  Future<BusinessDetailDecodable> fetchBusinessDetailById(
      {required String businessId});
}

// BusinessList Repositories
abstract class BusinessListRepository {
  Future<TypeBusinessListDecodable> fetchTypeBusinessList();
  Future<BusinessListDecodable> fetchBusinessList();
  Future<BusinessListDecodable> fetchNoveltyBusinessList();
  Future<BusinessListDecodable> fetchPopularBusinessList();
  Future<BusinessListDecodable> fetchBusinessListByTypeBusiness(
      {required int typeBusinessId});
  Future<BusinessListDecodable> fetchBusinessListByQuery(
      {required String query});
  Future<BusinessListDecodable> fetchBusinessListByRecentSearches(
      {required List<String> businessIds});
}

// Categories Repositories
abstract class CategoriesRepository {
  Future<BusinessCategoryDecodable> fetchCategory(
      {required int businessCategoryId});
  Future<BusinessCategoryListDecodable> fetchRestaurantCategories(
      {required String businessId});
  Future<BusinessCategoryListDecodable> fetchBusinessCategories(
      {required String businessId});
}

// Products Repositories
abstract class ProductRepository {
  Future<ProductListDecodable> fetchProductListByQuery(
      {required String businessId, required String query});
  Future<ProductListDecodable> fetchProductListByRecentSearches(
      {required List<String> productIds});
}

// Carts Repositories
abstract class CartRepository {
  Future<CartsListDecodable> fetchCartsList({required String userId});
}
