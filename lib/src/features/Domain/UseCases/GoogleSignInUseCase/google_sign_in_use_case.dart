import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/base/Constants/local_storage_keys.dart';
import 'package:easy_solutions/src/features/Domain/Entities/User/user_entity.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/LocalStorage/local_storage_use_case_parameters.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/LocalStorage/save_local_storage_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/User/SaveUserDataUseCase/save_user_data_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/User/SaveUserDataUseCase/save_user_data_use_case_parameters.dart';
import 'package:easy_solutions/src/services/GoogleSignInService/Entities/google_user_entity.dart';
import 'package:easy_solutions/src/services/GoogleSignInService/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/services/GoogleSignInService/Services/google_sign_in_service.dart';
import 'package:easy_solutions/src/utils/Helpers/Dates/date_helpers.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';

abstract class GoogleSignInUseCase {
  Future<Result<UserEntity, Failure>> execute();
}

class DefaultGoogleSignInUseCase extends GoogleSignInUseCase {
  // Dependencies
  final GoogleSignInService _googleSignInService;
  final SaveLocalStorageUseCase _saveLocalStorageUseCase;
  final SaveUserDataUseCase _saveUserDataUseCase;

  DefaultGoogleSignInUseCase(
      {GoogleSignInService? googleSignInService,
      SaveLocalStorageUseCase? saveLocalStorageUseCase,
      SaveUserDataUseCase? saveUserDataUseCase})
      : _googleSignInService =
            googleSignInService ?? DefaultGoogleSignInService(),
        _saveLocalStorageUseCase =
            saveLocalStorageUseCase ?? DefaultSaveLocalStorageUseCase(),
        _saveUserDataUseCase =
            saveUserDataUseCase ?? DefaultSaveUserDataUseCase();

  @override
  Future<Result<UserEntity, Failure>> execute() async {
    // Hacer el Google SignIn
    final user = await _googleSignInService.signInWithGoogle();

    // Mantener la sesión del usuario
    _saveLocalStorageUseCase.execute(
        parameters: SaveLocalStorageParameters(
            key: LocalStorageKeys.idToken, value: user.idToken ?? ""));

    final isUserInDatabase =
        await _googleSignInService.isUserInDatabase(uid: user.uid ?? "");
    if (isUserInDatabase) {
      return Result.success(_mapUserEntity(user: user));
    } else {
      return _saveUserDataInDataBase(user: user);
    }
  }
}

extension Mapper on DefaultGoogleSignInUseCase {
  UserEntity _mapUserEntity({required GoogleSignInUserEntity user}) {
    return UserEntity(
        localId: user.uid,
        role: UserRole.user.toShortString(),
        username: user.displayName,
        email: user.email,
        phone: user.phoneNumber,
        startDate: DateHelpers.getStartDate(),
        idToken: user.idToken);
  }
}

extension PrivateMethods on DefaultGoogleSignInUseCase {
  Future<Result<UserEntity, Failure>> _saveUserDataInDataBase(
      {required GoogleSignInUserEntity user}) {
    SaveUserDataUseCaseParameters parameters = SaveUserDataUseCaseParameters(
        localId: user.uid,
        role: UserRole.user,
        username: user.displayName,
        email: user.email,
        phone: user.phoneNumber,
        startDate: DateHelpers.getStartDate(),
        idToken: user.idToken);

    return _saveUserDataUseCase.execute(parameters: parameters);
  }
}