import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/data/Decodables/User/user_decodable.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Interfaces/interface.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Services/realtime_database_service.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';

extension Paths on DefaultFetchUserDataRepository {
  String get path => "users/";
}

class DefaultFetchUserDataRepository extends FetchUserDataRepository {
  // Dependencias
  final RealtimeDataBaseService _realtimeDatabaseService;

  DefaultFetchUserDataRepository({
    RealtimeDataBaseService? realtimeDatabaseService,
  }) : _realtimeDatabaseService =
           realtimeDatabaseService ?? DefaultRealtimeDataBaseService();

  @override
  Future<Result<UserDecodable, Failure>> fetchUserData() async {
    try {
      final result = await _realtimeDatabaseService.getData(
        path: path,
        requiresAuth: true,
      );
      UserDecodable decodable = UserDecodable.fromMap(result);
      return Result.success(decodable);
    } on Failure catch (f) {
      return Result.failure(f);
    }
  }
}
