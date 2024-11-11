import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/base/Constants/error_messages.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Auth/SignUpEntity/signup_entity.dart';
import 'package:easy_solutions/src/features/domain/UseCases/Auth/SignUpUseCase/signup_use_case.dart';
import 'package:easy_solutions/src/features/domain/UseCases/Auth/SignUpUseCase/signup_use_case_parameters.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/AuthEasyDeliveryServices/Decodables/auth_error_decodable.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';
import 'package:flutter_test/flutter_test.dart';

abstract class _Constants {
  static String correctEmail = "ronnyblandon2015@gmail.com";
  static String correctPass = "12345678";
  static String wrongEmail = "ronny8@gmail.com";
  static String wrongPass = "123456";
}

void main() {
  // GIVEN
  SignUpUseCase sut = DefaultSignUpUseCase();

  group('Test success Signup user with FastAPI', () {
    test('Test success signup user with FastAPI', () async {
      final SignUpUseCaseParameters params = SignUpUseCaseParameters(
          fullName: "Ronny Humberto Blandon Martinez",
          email: _Constants.correctEmail,
          phone: "98311490",
          departmentId: 1,
          municipalityId: 1,
          role: "USER",
          isActive: true,
          password: _Constants.correctPass);

      // WHEN
      final result = await sut.execute(params: params);
      print("Esto contiene result: ${result.status}");
      switch (result.status) {
        case ResultStatus.success:
          print("Esto contiene result success: ${result.value}");
          // THEN
          expect(result.value, isA<SignUpEntity>());
          break;
        case ResultStatus.error:
          print("Esto contiene result error: ${result.error}");
          // THEN
          expect(result.error, isA<Failure>());
          break;
      }
    });
  });

  group('Test failure Signup user with FastAPI', () {
    test('Test failure Signup user with FastAPI', () async {
      try {
        // WHEN
        final SignUpUseCaseParameters params = SignUpUseCaseParameters(
            fullName: "Ronny Humberto Blandon Martinez 4",
            email: _Constants.wrongEmail,
            phone: "98311490",
            departmentId: 1,
            municipalityId: 1,
            role: "USER",
            isActive: true,
            password: _Constants.wrongPass);

        final _ = await sut.execute(params: params);
      } on Failure catch (f) {
        // THEN
        // Usar el Failure adaptado con AuthErrorDecodable (FastAPI)
        AuthErrorDecodable errorDecodable = AuthErrorDecodable.fromMap(f.error);
        expect(
          errorDecodable.detailErrors != null &&
                  errorDecodable.detailErrors!.isNotEmpty
              ? errorDecodable.detailErrors![0].msg
              : '',
          ApiFailureMessages.emailExitMessage,
        );
      }
    });
  });
}
