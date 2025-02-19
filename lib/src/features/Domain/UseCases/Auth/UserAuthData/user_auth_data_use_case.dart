import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/base/Constants/error_messages.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Auth/UserAuthData/user_auth_data_entity.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Auth/UserAuthData/user_auth_data_use_case_body_parameters.dart';
import 'package:easy_solutions/src/features/data/Repositories/Auth/UserAuthData/user_auth_data_repository_body_parameters.dart';
import 'package:easy_solutions/src/features/data/Repositories/Auth/UserAuthData/user_auth_data_repository.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';

abstract class UserAuthDataUseCase {
  Future<Result<UserAuthDataEntity, Failure>> execute(
      {required GetUserDataUseCaseParameters parameters});
}

class DefaultUserAuthDataUseCase extends UserAuthDataUseCase {
  // Dependencias
  final UserAuthDataRepository _userAuthDataRepository;

  DefaultUserAuthDataUseCase({UserAuthDataRepository? userAuthDataRepository})
      : _userAuthDataRepository =
            userAuthDataRepository ?? DefaultUserAuthDataRepository();

  @override
  Future<Result<UserAuthDataEntity, Failure>> execute(
      {required GetUserDataUseCaseParameters parameters}) {
    return _userAuthDataRepository
        .getUserAuthData(
            parameters:
                GetUserDataBodyParameters(accessToken: parameters.accessToken))
        .then((result) {
      switch (result.status) {
        case ResultStatus.success:
          if (result.value == null) {
            return Result.failure(Failure.fromMessage(
                message: AppFailureMessages.unExpectedErrorMessage));
          }
          return Result.success(
              UserAuthDataEntity.fromMap(result.value!.toMap()));
        case ResultStatus.error:
          return Result.failure(result.error);
      }
    });
  }
}
