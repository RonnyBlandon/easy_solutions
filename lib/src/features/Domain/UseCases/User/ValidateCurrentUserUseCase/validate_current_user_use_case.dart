import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Auth/UserAuthData/user_auth_data_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Auth/UserAuthData/user_auth_data_use_case_body_parameters.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';

abstract class ValidateCurrentUserUseCase {
  Future<bool> execute({required String accessToken});
}

class DefaultValidateCurrentUserUseCase extends ValidateCurrentUserUseCase {
  final UserAuthDataUseCase _userAuthDataUseCase;

  DefaultValidateCurrentUserUseCase({UserAuthDataUseCase? userAuthDataUseCase})
      : _userAuthDataUseCase =
            userAuthDataUseCase ?? DefaultUserAuthDataUseCase();

  @override
  Future<bool> execute({required String accessToken}) async {
    try {
      return _userAuthDataUseCase
          .execute(
              parameters:
                  GetUserDataUseCaseParameters(accessToken: accessToken))
          .then((result) {
        switch (result.status) {
          case ResultStatus.success:
            return true;
          case ResultStatus.error:
            return false;
        }
      });
    } on Failure {
      return false;
    }
  }
}
