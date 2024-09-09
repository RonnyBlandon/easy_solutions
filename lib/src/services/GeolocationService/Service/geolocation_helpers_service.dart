import 'package:geolocator/geolocator.dart';
import '../Interfaces/geolocation_service_interfaces.dart';

class DefaultGeolocationHelpersService extends GeolocationHelpersService {
  @override
  double getDistanceBetweenInKilometers(
      double startLatitude,
      double startLongitude,
      double destinationLatitude,
      double destinationLongitude) {
    return Geolocator.distanceBetween(startLatitude, startLongitude,
            destinationLatitude, destinationLongitude) /
        1000;
  }

  @override
  double getDistanceBetweenInMeters(double startLatitude, double startLongitude,
      double destinationLatitude, double destinationLongitude) {
    return Geolocator.distanceBetween(startLatitude, startLongitude,
        destinationLatitude, destinationLongitude);
  }
}
