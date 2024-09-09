import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/services/GeolocationService/Entities/geolocation_service_entities.dart';
import 'package:easy_solutions/src/services/GeolocationService/Interfaces/geolocation_service_interfaces.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';
import 'package:geolocator/geolocator.dart';

import '../Mappers/geolocation_service_mappers.dart';

class MockGeolocationService extends GeolocationService {
  @override
  Future<Result<PositionEntity, Failure>> getCurrentPosition() async {
    var fakePosition = Position(
        longitude: 2.169188,
        latitude: 41.386400,
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        altitudeAccuracy: 1,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        headingAccuracy: 1);

    return Result.success(GeolocationServiceMappers.mapPosition(fakePosition));
  }

  @override
  Future<LocationPermissionStatus> getPermissionStatus() async {
    return LocationPermissionStatus.denied;
  }
}
