import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/services/GeolocationService/Entities/geolocation_service_entities.dart';
import 'package:easy_solutions/src/services/GeolocationService/Interfaces/geolocation_service_interfaces.dart';
import 'package:easy_solutions/src/services/GeolocationService/Service/geolocation_helpers_service.dart';
import 'package:easy_solutions/src/services/GeolocationService/Service/geolocation_service.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';

import 'geolocation_use_case_parameters.dart';

abstract class GeolocationUseCase {
  Future<Result<PositionEntity, Failure>> getCurrentPosition();
  Future<LocationPermissionStatus> getPermissionStatus();
  Future<double> getDistanceBetweenYourCurrentPositionAnd(
      Destination destination);
}

class DefaultGeolocationUseCase extends GeolocationUseCase {
  // Dependencies
  final GeolocationService _geolocationService;
  final GeolocationHelpersService _geolocationHelpersService;

  DefaultGeolocationUseCase(
      {GeolocationService? geolocationService,
      GeolocationHelpersService? geolocationHelpersService})
      : _geolocationService = geolocationService ??
            DefaultGeolocationService(), // Producción: DefaultGeolocationService() Pruebas: MockGeolocationService
        _geolocationHelpersService =
            geolocationHelpersService ?? DefaultGeolocationHelpersService();

  @override
  Future<Result<PositionEntity, Failure>> getCurrentPosition() {
    return _geolocationService.getCurrentPosition();
  }

  @override
  Future<double> getDistanceBetweenYourCurrentPositionAnd(
      Destination destination) async {
    final userPosition = await _geolocationService.getCurrentPosition();
    return _geolocationHelpersService.getDistanceBetweenInKilometers(
        userPosition.value?.latitude ?? 0.0,
        userPosition.value?.longitude ?? 0.0,
        destination.destinationLatitude,
        destination.destinationLongitude);
  }

  @override
  Future<LocationPermissionStatus> getPermissionStatus() {
    return _geolocationService.getPermissionStatus();
  }
}
