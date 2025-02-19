import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/base/Constants/error_messages.dart';
import 'package:easy_solutions/src/features/Domain/Entities/User/user_entity.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/data/Repositories/User/fetch_user_data_repository.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';

abstract class FetchUserDataUseCase {
  Future<Result<UserEntity, Failure>> execute({required String localId});
}

class DefaultFetchUserDataUseCase extends FetchUserDataUseCase {
  // Dependencias
  final FetchUserDataRepository _fetchUserDataRepository;

  DefaultFetchUserDataUseCase(
      {FetchUserDataRepository? fetchUserDataRepository})
      : _fetchUserDataRepository =
            fetchUserDataRepository ?? DefaultFetchUserDataRepository();

  @override
  Future<Result<UserEntity, Failure>> execute({required String localId}) {
    return _fetchUserDataRepository
        .fetchUserData(localId: localId)
        .then((result) {
      switch (result.status) {
        case ResultStatus.success:
          if (result.value == null) {
            return Result.failure(Failure.fromMessage(
                message: AppFailureMessages.unExpectedErrorMessage));
          }
          return Result.success(UserEntity.fromMap(result.value!.toMap()));
        case ResultStatus.error:
          return Result.failure(result.error);
      }
    });
  }
}
