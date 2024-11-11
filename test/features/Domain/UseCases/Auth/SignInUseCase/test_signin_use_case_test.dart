import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/base/Constants/error_messages.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Auth/SignInEntity/signin_entity.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Auth/SignInUseCase/signin_use_case.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Auth/SignInUseCase/signin_use_case_parameters.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/AuthEasyDeliveryServices/Decodables/auth_error_decodable.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';
import 'package:flutter_test/flutter_test.dart';

abstract class _Constants {
  static String correctEmail = "ronnyblandon2015@gmail.com";
  static String correctPass = "12345678";
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
      print("Esto contiene result: ${result.status}");
      switch (result.status) {
        // THEN
        case ResultStatus.success:
          print("Esto contiene result success: ${result.value}");
          expect(result.value, isA<SignInEntity>());
          break;
        case ResultStatus.error:
          print("Esto contiene result success: ${result.error}");
          expect(result.error, isA<Failure>());
          break;
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
          error.detailErrors != null && error.detailErrors!.isNotEmpty
              ? error.detailErrors![0].msg
              : '',
          ApiFailureMessages.emailNotFoundMessage,
        );
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
        expect(
          error.detailErrors != null && error.detailErrors!.isNotEmpty
              ? error.detailErrors![0].msg
              : '',
          ApiFailureMessages.invalidPasswordMessage,
        );
      }
    });
  });
}
