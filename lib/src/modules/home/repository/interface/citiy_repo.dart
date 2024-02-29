import 'package:foodcourt_task/src/modules/home/model/city_model.dart';
import 'package:foodcourt_task/src/modules/home/model/location_model.dart';

abstract class CitiesRepository {
  Future<List<CityModel>> getCities();
  Future<LocationModel?> getCarouselReports({
    required String lon,
    required String lat,
  });
}
