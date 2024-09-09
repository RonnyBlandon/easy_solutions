import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/services/GeolocationService/Entities/geolocation_service_entities.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';

abstract class GeolocationService {
  Future<Result<PositionEntity, Failure>> getCurrentPosition();
  Future<LocationPermissionStatus> getPermissionStatus();
}

abstract class GeolocationHelpersService {
  double getDistanceBetweenInMeters(double startLatitude, double startLongitude,
      double destinationLatitude, double destinationLongitude);
  double getDistanceBetweenInKilometers(
      double startLatitude,
      double startLongitude,
      double destinationLatitude,
      double destinationLongitude);
}
