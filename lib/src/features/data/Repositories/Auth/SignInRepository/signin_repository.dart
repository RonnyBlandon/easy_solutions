import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/data/Repositories/Auth/SignInRepository/signin_body_parameters.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/AuthEasyDeliveryServices/Decodables/sign_in_decodable.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/AuthEasyDeliveryServices/Interfaces/auth_api_interface.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/AuthEasyDeliveryServices/Services/sign_in_auth_services.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';

class DefaultSignInRepository extends SignInRepository {
  // Dependencias
  final SignInService _signInService;

  DefaultSignInRepository({SignInService? signInService})
      : _signInService = signInService ?? DefaultSignInServices();

  @override
  Future<Result<SignInDecodable, Failure>> signIn(
      {required SignInBodyParameters params}) async {
    try {
      final result =
          await _signInService.signIn(bodyParameters: params.toMap());
      SignInDecodable decodable = SignInDecodable.fromMap(result);
      return Result.success(decodable);
    } on Failure catch (f) {
      return Result.failure(Failure.getApiAuthErrorMessage(error: f.error));
    }
  }
}
