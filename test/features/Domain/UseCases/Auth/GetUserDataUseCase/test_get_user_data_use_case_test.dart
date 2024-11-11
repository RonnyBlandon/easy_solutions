import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/base/Constants/local_storage_keys.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Auth/UserAuthData/user_auth_data_entity.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Auth/UserAuthData/user_auth_data_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Auth/UserAuthData/user_auth_data_use_case_body_parameters.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // GIVEN
  final UserAuthDataUseCase sut = DefaultUserAuthDataUseCase();

  group('Test success response to ResetPasswordUserCase', () {
    test('Test success reset password', () async {
      GetUserDataUseCaseParameters parameters = GetUserDataUseCaseParameters(
          accessToken: LocalStorageKeys.accessToken);
      // WHEN
      var result = await sut.execute(parameters: parameters);
      print("Esto contiene result: ${result.status}");
      switch (result.status) {
        // THEN
        case ResultStatus.success:
          print("Esto contiene result success: ${result.value}");
          expect(result.value, isA<UserAuthDataEntity>());
          break;
        case ResultStatus.error:
          print("Esto contiene result success: ${result.error}");
          expect(result.error, isA<Failure>());
          break;
      }
      //return result;
    });
  });
}
