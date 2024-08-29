import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/features/data/Decodables/Auth/UserAuthData/user_auth_data_decodable.dart';
import 'package:easy_solutions/src/features/data/Decodables/User/user_decodable.dart';
import 'package:easy_solutions/src/features/data/Repositories/Auth/SignInRepository/signin_body_parameters.dart';
import 'package:easy_solutions/src/features/data/Repositories/Auth/UserAuthData/user_auth_data_repository_body_parameters.dart';
import 'package:easy_solutions/src/features/data/Repositories/User/user_body_parameters.dart';
import 'package:easy_solutions/src/services/FirebaseServices/AuthFirebaseServices/Decodables/reset_password_decodable.dart';
import 'package:easy_solutions/src/services/FirebaseServices/AuthFirebaseServices/Decodables/sign_in_decodable.dart';
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
}

abstract class FetchLocalStorageRepository {
  Future<String?> fetchInLocalStorage({required String key});
}

abstract class RemoveLocalStorageRepository {
  Future<void> removeLocalStorage({required String key});
}
