import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/base/Constants/error_messages.dart';
import 'package:easy_solutions/src/features/Domain/Entities/User/user_entity.dart';
import 'package:easy_solutions/src/features/Domain/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/data/Repositories/User/save_user_data_repository.dart';
import 'package:easy_solutions/src/features/data/Repositories/User/user_body_parameters.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';
import 'save_user_data_use_case_parameters.dart';

abstract class SaveUserDataUseCase {
  Future<Result<UserEntity, Failure>> execute(
      {required SaveUserDataUseCaseParameters parameters});
}

class DefaultSaveUserDataUseCase extends SaveUserDataUseCase {
  // Dependencias
  final SaveUserDataRepository _saveUserDataRepository;

  DefaultSaveUserDataUseCase({SaveUserDataRepository? saveUserDataRepository})
      : _saveUserDataRepository =
            saveUserDataRepository ?? DefaultSaveUserDataRepository();

  @override
  Future<Result<UserEntity, Failure>> execute(
      {required SaveUserDataUseCaseParameters parameters}) {
    UserBodyParameters params = UserBodyParameters(
        localId: parameters.localId,
        role: parameters.role?.toShortString(),
        names: parameters.names,
        surnames: parameters.surnames,
        email: parameters.email,
        phone: parameters.phone,
        idToken: parameters.idToken);

    return _saveUserDataRepository
        .saveUserData(parameters: params)
        .then((result) {
      switch (result.status) {
        case ResultStatus.success:
          if (result.value == null) {
            return Result.failure(Failure.fromMessage(
                message: AppFailureMessages.unExpectedErrorMessage));
          }
          var entity = UserEntity.fromMap(result.value!.toMap());
          return Result.success(entity);

        case ResultStatus.error:
          return Result.failure(result.error);
      }
    });
  }
}