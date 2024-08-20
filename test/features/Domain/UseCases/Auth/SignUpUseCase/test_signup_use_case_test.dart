import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/base/Constants/error_messages.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Auth/SignUpEntity/signup_entity.dart';
import 'package:easy_solutions/src/features/domain/UseCases/Auth/SignUpUseCase/signup_use_case.dart';
import 'package:easy_solutions/src/features/domain/UseCases/Auth/SignUpUseCase/signup_use_case_parameters.dart';
import 'package:easy_solutions/src/services/FirebaseServices/AuthFirebaseServices/Decodables/auth_error_decodable.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';
import 'package:flutter_test/flutter_test.dart';

abstract class _Constatns {
  static String correctEmail = "ronny4@gmail.com";
  static String correctPass = "123456";
  static String wrongEmail = "ronny8@gmail.com";
  static String wrongPass = "123456";
}

void main() {
  // GIVEN
  SignUpUseCase sut = DefaultSignUpUseCase();

  group('Test success Signup user in Firebase', () {
    test('Test success signup user in Firebase', () async {
      final SignUpUseCaseParameters params = SignUpUseCaseParameters(
          names: "Ronny Humberto 4",
          surnames: "Blandon Martinez",
          email: _Constatns.correctEmail,
          phone: "98311490",
          password: _Constatns.correctPass,
          repeatPassword: _Constatns.correctPass);

      // WHEN
      final result = await sut.execute(params: params);

      switch (result.status) {
        case ResultStatus.success:
          // THEN
          expect(result.value, isA<SignUpEntity>());
          break;
        case ResultStatus.error:
          //THEN
          expect(result.error, Failure);
          break;
      }
    });
  });

  group('Test failure Signup user in Firebase', () {
    test('Test failure Signup user in Firebase', () async {
      try {
        // WHEN
        final SignUpUseCaseParameters params = SignUpUseCaseParameters(
            names: "Ronny Humberto 4",
            surnames: "Blandon Martinez",
            email: _Constatns.wrongEmail,
            phone: "98311490",
            password: _Constatns.wrongPass,
            repeatPassword: _Constatns.wrongPass);

        final _ = await sut.execute(params: params);
      } on Failure catch (f) {
        // THEN
        AuthErrorDecodable error = f as AuthErrorDecodable;
        expect(error.error!.message, FirebaseFailureMessages.emailExitMessage);
      }
    });
  });
}
