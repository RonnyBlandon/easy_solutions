import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/base/Constants/error_messages.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Auth/SignInEntity/signin_entity.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Auth/SignInUseCase/signin_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Auth/SignInUseCase/signin_use_case_parameters.dart';
import 'package:easy_solutions/src/services/FirebaseServices/AuthFirebaseServices/Decodables/auth_error_decodable.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';
import 'package:flutter_test/flutter_test.dart';

abstract class _Constants {
  static String correctEmail = "ronny8@gmail.com";
  static String correctPass = "123456";
  static String wrongEmail = "ronny550@gmail.com";
  static String wrongPass = "12345678524";
}

void main() {
  // GIVEN
  final SignInUseCase sut = DefaultSignInUseCase();

  group('Test success response to SignInUseCase', () {
    test('Test success signIn feature with correct email and password',
        () async {
      final SigninUseCaseParameters params = SigninUseCaseParameters(
          email: _Constants.correctEmail, password: _Constants.correctPass);

      // WHEN
      var result = await sut.execute(params: params);
      switch (result.status) {
        // THEN
        case ResultStatus.success:
          expect(result.value, isA<SignInEntity>());
        case ResultStatus.error:
          expect(result.error, Failure);
      }
    });
  });

  group('Test failure response to SignInUseCase', () {
    test('Test failure response to SignInUseCase', () async {
      // GIVEN
      final SigninUseCaseParameters params = SigninUseCaseParameters(
          email: _Constants.wrongEmail, password: _Constants.wrongPass);

      try {
        final _ = await sut.execute(params: params);
      } on Failure catch (f) {
        AuthErrorDecodable error = f as AuthErrorDecodable;
        // THEN
        expect(
            error.error!.message, FirebaseFailureMessages.emailNotFoundMessage);
      }
    });

    test('Test failure response to SignInUseCase with wrong password',
        () async {
      // GIVEN
      final SigninUseCaseParameters params = SigninUseCaseParameters(
          email: _Constants.correctEmail, password: _Constants.wrongPass);

      try {
        final _ = await sut.execute(params: params);
      } on Failure catch (f) {
        AuthErrorDecodable error = f as AuthErrorDecodable;
        // THEN
        expect(error.error!.message,
            FirebaseFailureMessages.invalidPasswordMessage);
      }
    });
  });
}
