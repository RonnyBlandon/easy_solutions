import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/services/GeolocationService/Entities/geolocation_service_entities.dart';
import 'package:easy_solutions/src/services/GeolocationService/Interfaces/geolocation_service_interfaces.dart';
import 'package:easy_solutions/src/services/GeolocationService/Mappers/geolocation_service_mappers.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';
import 'package:geolocator/geolocator.dart';

abstract class GeoLocationFailureMessages {
  // Error Messages
  static String locationServicesDisabled =
      "Los servicios de ubicación están deshabilitados.";
  static String locationPermissionsDenied =
      "Los permisos de ubicación estan denegados";
  static String locationPermissionsDeniedForever =
      "Los permisos de ubicación están permanentemente denegados, no podemos solicitar permisos.";
}

class DefaultGeolocationService extends GeolocationService {
  @override
  Future<Result<PositionEntity, Failure>> getCurrentPosition() async {
    try {
      Position position = await _determinePosition();
      return Result.success(GeolocationServiceMappers.mapPosition(position));
    } catch (e) {
      print("Esto tiene e en getCurrentPosition de geolocation_service: $e");
      return Result.failure(Failure.fromMessage(message: e.toString()));
    }
  }

  @override
  Future<LocationPermissionStatus> getPermissionStatus() async {
    LocationPermission permission = await Geolocator.checkPermission();
    switch (permission) {
      case LocationPermission.denied:
        return LocationPermissionStatus.denied;
      case LocationPermission.deniedForever:
        return LocationPermissionStatus.deniedForever;
      case LocationPermission.whileInUse:
        return LocationPermissionStatus.allowed;
      case LocationPermission.always:
        return LocationPermissionStatus.allowed;
      case LocationPermission.unableToDetermine:
        return LocationPermissionStatus.denied;
    }
  }
}

// Plugin Methods
extension PrivateMethods on DefaultGeolocationService {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error(GeoLocationFailureMessages.locationServicesDisabled);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error(
          GeoLocationFailureMessages.locationPermissionsDenied,
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        GeoLocationFailureMessages.locationPermissionsDeniedForever,
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
