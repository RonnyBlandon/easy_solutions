import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/features/data/Repositories/Auth/SignUpRepository/signup_body_parameters.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/AuthEasyDeliveryServices/Decodables/sign_up_decodable.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/AuthEasyDeliveryServices/Interfaces/auth_api_interface.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/AuthEasyDeliveryServices/Services/sign_up_auth_service.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';

//Auth Repositories
abstract class SignUpRepository {
  Future<Result<SignUpDecodable, Failure>> signUp(
      {required SignUpBodyParameters params});
}

class DefaultSignUpRepository extends SignUpRepository {
  // Dependecias
  final SignUpService _signUpService;

  DefaultSignUpRepository({SignUpService? signUpService})
      : _signUpService = signUpService ?? DefaultSignUpService();

  @override
  Future<Result<SignUpDecodable, Failure>> signUp(
      {required SignUpBodyParameters params}) async {
    try {
      final result =
          await _signUpService.signUp(bodyParameters: params.toMap());
      SignUpDecodable decodable = SignUpDecodable.fromMap(result);
      return Result.success(decodable);
    } on Failure catch (f) {
      return Result.failure(Failure.getApiAuthErrorMessage(error: f.error));
    }
  }
}
