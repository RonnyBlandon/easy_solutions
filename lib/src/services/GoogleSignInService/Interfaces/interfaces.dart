import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/AuthEasyDeliveryServices/Interfaces/auth_api_interface.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';
import '../Entities/google_user_entity.dart';

abstract class GoogleSignInService extends BaseApiService {
  String endpoint =
      BaseApiService.baseUrl + BaseApiService.googleSignInEndpoint;

  Future<Result<GoogleSignInUserEntity, Failure>> googleSignIn({
    required Map<String, dynamic> bodyParameters,
  });
  Future<GoogleSignInUserEntity> signInWithGoogle();
  Future<bool> isUserInDatabase();
}
