import 'package:easy_solutions/src/features/Domain/UseCases/Auth/ResetPasswordUseCase/reset_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // GIVEN
  final ResetPasswordUseCase sut = DefaultResetPasswordUseCase();

  group('Test success response to ResetPasswordUserCase', () {
    test('Test success reset password', () async {
      String email = "ronnyblandon2015@gmail.com";
      // WHEN
      var result = await sut.execute(email: email);
      return result;
    });
  });
}
