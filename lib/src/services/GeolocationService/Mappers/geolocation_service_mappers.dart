import 'package:easy_solutions/src/services/GeolocationService/Entities/geolocation_service_entities.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationServiceMappers {
  static PositionEntity mapPosition(Position position) {
    // Aqui en este punto podemos probar
    print("Geolocation- Longitud: ${position.longitude}");
    print("Geolocation- Latitude: ${position.latitude}");
    return PositionEntity(
        longitude: position.longitude,
        latitude: position.latitude,
        timestamp: position.timestamp,
        accuracy: position.accuracy,
        altitude: position.altitude,
        heading: position.heading,
        speed: position.speed,
        speedAccuracy: position.speedAccuracy);
  }
}
