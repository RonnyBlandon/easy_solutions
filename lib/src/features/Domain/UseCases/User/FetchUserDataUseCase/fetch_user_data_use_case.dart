import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/base/Constants/error_messages.dart';
import 'package:easy_solutions/src/features/Domain/Entities/User/user_entity.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/data/Repositories/User/fetch_user_data_repository.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';

abstract class FetchUserDataUseCase {
  Future<UserEntity> execute();
}

class DefaultFetchUserDataUseCase extends FetchUserDataUseCase {
  // Dependencias
  final FetchUserDataRepository _fetchUserDataRepository;

  DefaultFetchUserDataUseCase({
    FetchUserDataRepository? fetchUserDataRepository,
  }) : _fetchUserDataRepository =
           fetchUserDataRepository ?? DefaultFetchUserDataRepository();

  @override
  Future<UserEntity> execute() {
    return _fetchUserDataRepository.fetchUserData().then((result) {
      switch (result.status) {
        case ResultStatus.success:
          if (result.value == null) {
            return Future.error(
              Failure.fromMessage(
                message: AppFailureMessages.unExpectedErrorMessage,
              ),
            );
          }
          return UserEntity.fromMap(result.value!.toMap());
        case ResultStatus.error:
          return Future.error(
            Failure.fromMessage(
              message: AppFailureMessages.unExpectedErrorMessage,
            ),
          );
      }
    });
  }
}
