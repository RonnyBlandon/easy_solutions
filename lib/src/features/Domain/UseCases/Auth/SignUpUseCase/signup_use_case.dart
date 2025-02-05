import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/base/Constants/error_messages.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Auth/SignUpEntity/signup_entity.dart';
import 'package:easy_solutions/src/features/Domain/Entities/User/user_entity.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/User/SaveUserDataUseCase/save_user_data_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/User/SaveUserDataUseCase/save_user_data_use_case_parameters.dart';
import 'package:easy_solutions/src/features/data/Repositories/Auth/SignUpRepository/signup_body_parameters.dart';
import 'package:easy_solutions/src/features/data/Repositories/Auth/SignUpRepository/signup_repository.dart';
import 'package:easy_solutions/src/utils/Helpers/Dates/date_helpers.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';
import 'signup_use_case_parameters.dart';

abstract class SignUpUseCase {
  Future<Result<SignUpEntity, Failure>> execute(
      {required SignUpUseCaseParameters params});
}

class DefaultSignUpUseCase extends SignUpUseCase {
  // Dependencias
  final SignUpRepository _signUpRepository;
  final SaveUserDataUseCase _saveUserDataUseCase;

  DefaultSignUpUseCase(
      {SignUpRepository? signUpRepository,
      SaveUserDataUseCase? saveUserDataUseCase})
      : _signUpRepository = signUpRepository ?? DefaultSignUpRepository(),
        _saveUserDataUseCase =
            saveUserDataUseCase ?? DefaultSaveUserDataUseCase();

  @override
  Future<Result<SignUpEntity, Failure>> execute(
      {required SignUpUseCaseParameters params}) {
    return _signUpRepository
        .signUp(
            params: SignUpBodyParameters(
                fullName: params.fullName,
                email: params.email,
                phone: params.phone,
                departmentId: params.departmentId,
                municipalityId: params.municipalityId,
                role: params.role,
                isActive: params.isActive,
                password: params.password))
        .then((result) {
      switch (result.status) {
        case ResultStatus.success:
          // Null Check
          if (result.value == null) {
            return Result.failure(Failure.fromMessage(
                message: AppFailureMessages.unExpectedErrorMessage));
          }
          SignUpEntity entity = SignUpEntity.fromMap(result.value!.toMap());
          // Guardamos el nuevo usuario en la base de datos
          return saveUserDataInDatabase(params: params, entity: entity);
        case ResultStatus.error:
          return Result.failure(result.error);
      }
    });
  }
}

extension on DefaultSignUpUseCase {
  Future<Result<SignUpEntity, Failure>> saveUserDataInDatabase(
      {required SignUpUseCaseParameters params, required SignUpEntity entity}) {
    SaveUserDataUseCaseParameters parameters = SaveUserDataUseCaseParameters(
        localId: entity.localId,
        role: UserRole.user,
        fullName: params.fullName,
        email: params.email,
        phone: params.phone,
        departmentId: params.departmentId,
        municipalityId: params.municipalityId,
        startDate: DateHelpers.getStartDate(),
        accessToken: entity.accessToken);

    return _saveUserDataUseCase.execute(parameters: parameters).then((result) {
      switch (result.status) {
        case ResultStatus.success:
          return Result.success(entity);
        case ResultStatus.error:
          return Result.failure(result.error);
      }
    });
  }
}
