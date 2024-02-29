
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foodcourt_task/src/core/constant.dart';
import 'package:foodcourt_task/src/core/logger.dart';
import 'package:foodcourt_task/src/modules/home/model/city_model.dart';
import 'package:foodcourt_task/src/modules/home/model/location_model.dart';
import '../interface/citiy_repo.dart';
import 'package:http/http.dart' as http;

class CitiesImpl extends CitiesRepository {
  @override
  Future<List<CityModel>> getCities() async {
    try {
      String jsonString = await rootBundle.loadString('assets/cities/ng.json');
      final cityModel = cityModelFromJson(jsonString);
      return cityModel;
    } catch (e) {
      logger.i('Error loading cities: $e');
      return [];
    }
  }

  @override
  Future<LocationModel?> getCarouselReports({
    required String lon,
    required String lat,
  }) async {
    String endpointKey = dotenv.env['API_ENDPOINT_KEY']!;
    try {
      // Uri parsing before getting the uri
      var url =
          Uri.parse('${AppConst.baseUrl}?lat=$lat&lon=$lon&appid=$endpointKey');

      // saved response in the response variable
      final response = await http.get(url);
      if (response.statusCode == AppConst.success) {
        final locationModel = locationModelFromJson(response.body);
        // logging the response to see and debug
        logger.i(response.body.toString());

        // logging my status code as well
        logger.i(response.statusCode.toString());

        return locationModel;
      }
      logger.i(response.request);
      logger.i(response.statusCode.toString());
      return null;
    } catch (e) {
      //
    }
    return null;
  }
}
