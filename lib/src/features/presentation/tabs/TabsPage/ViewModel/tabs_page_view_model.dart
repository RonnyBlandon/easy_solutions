import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/Domain/UseCases/Geolocation/geolocation_use_case.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/loading_state_provider.dart';
import 'package:easy_solutions/src/services/GeolocationService/Entities/geolocation_service_entities.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';

abstract class TabsViewModelInput {
  // Exposed Methods
  Future<Result<bool, Failure>> getCurrentPosition();
  Future<LocationPermissionStatus> getPermissionStatus();
}

abstract class TabsViewModel extends TabsViewModelInput with BaseViewModel {}

class DefaultTabsViewModel extends TabsViewModel {
  // Dependencies
  final GeolocationUseCase _geolocationUseCase;

  DefaultTabsViewModel({GeolocationUseCase? geolocationUseCase})
      : _geolocationUseCase = geolocationUseCase ?? DefaultGeolocationUseCase();

  @override
  void initState({required LoadingStateProvider loadingStateProvider}) {
    loadingState = loadingStateProvider;
  }

  @override
  Future<Result<bool, Failure>> getCurrentPosition() async {
    return await _geolocationUseCase.getCurrentPosition().then((result) {
      switch (result.status) {
        case ResultStatus.success:
          return Result.success(true);
        case ResultStatus.error:
          return Result.failure(result.error);
      }
    });
  }

  @override
  Future<LocationPermissionStatus> getPermissionStatus() {
    return _geolocationUseCase.getPermissionStatus();
  }
}
