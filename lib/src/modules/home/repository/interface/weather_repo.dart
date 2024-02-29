//Repository pattern for dependency injection
import 'package:geolocator/geolocator.dart';

abstract class WeatherRepository {
  Future<Position?> getCurrentLocation();
  Future<Object> getWeatherReports({required String lon, required String lat});
}
