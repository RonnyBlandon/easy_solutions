import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/data/Decodables/Auth/UserAuthData/user_auth_data_decodable.dart';
import 'package:easy_solutions/src/features/data/Repositories/Auth/UserAuthData/user_auth_data_repository_body_parameters.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/AuthEasyDeliveryServices/Interfaces/auth_api_interface.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/AuthEasyDeliveryServices/Services/get_user_auth_data_service.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';

class DefaultUserAuthDataRepository extends UserAuthDataRepository {
  // Dependencias
  final GetUserAuthDataService _getUserAuthDataService;

  DefaultUserAuthDataRepository(
      {GetUserAuthDataService? getUserAuthDataService})
      : _getUserAuthDataService =
            getUserAuthDataService ?? DefaultGetUserAuthDataService();

  @override
  Future<Result<UserAuthDataDecodable, Failure>> getUserAuthData(
      {required GetUserDataBodyParameters parameters}) async {
    try {
      final result = await _getUserAuthDataService.getUserAuthData(
          bodyParameters: parameters.toMap());
      UserAuthDataDecodable decodable = UserAuthDataDecodable.fromMap(result);
      return Result.success(decodable);
    } on Failure catch (f) {
      return Result.failure(Failure.getApiAuthErrorMessage(error: f.error));
    }
  }
}
