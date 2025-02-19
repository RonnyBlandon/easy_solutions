import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/base/Constants/error_messages.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Auth/SignInEntity/signin_entity.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/data/Repositories/Auth/SignInRepository/signin_body_parameters.dart';
import 'package:easy_solutions/src/features/data/Repositories/Auth/SignInRepository/signin_repository.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';

import 'signin_use_case_parameters.dart';

abstract class SignInUseCase {
  Future<Result<SignInEntity, Failure>> execute(
      {required SigninUseCaseParameters params});
}

class DefaultSignInUseCase extends SignInUseCase {
  // Dependecias
  final SignInRepository _signInRepository;

  DefaultSignInUseCase({SignInRepository? signInRepository})
      : _signInRepository = signInRepository ?? DefaultSignInRepository();

  @override
  Future<Result<SignInEntity, Failure>> execute(
      {required SigninUseCaseParameters params}) {
    return _signInRepository
        .signIn(
            params: SignInBodyParameters(
                email: params.email, password: params.password))
        .then((result) {
      switch (result.status) {
        case ResultStatus.success:
          if (result.value == null) {
            return Result.failure(Failure.fromMessage(
                message: AppFailureMessages.unExpectedErrorMessage));
          }
          var entity = SignInEntity.fromMap(result.value!.toMap());

          return Result.success(entity);
        case ResultStatus.error:
          return Result.failure(result.error);
      }
    });
  }
}
