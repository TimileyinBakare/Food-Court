import 'dart:developer';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foodcourt_task/src/core/constant.dart';
import 'package:foodcourt_task/src/core/logger.dart';
import 'package:foodcourt_task/src/modules/home/repository/app_status.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../../model/location_model.dart';
import '../interface/weather_repo.dart';

//Implementation for the abstract class using repository pattern
class WeatherReportImpl extends WeatherRepository {
  @override
  Future<Position?> getCurrentLocation() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          return Future.error('Location Not Available');
        }
      }
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      logger.i(position.toString());
      return position;
    } catch (e) {
      logger.i(e.toString());
      return null;
    }
  }

  @override
  Future<Object> getWeatherReports({
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

        return Success(code: response.statusCode, response: locationModel);
      }
      logger.i(response.request);
      log(response.request.toString());
      logger.i(response.statusCode.toString());
      return Failure(
          code: AppConst.userInvalidResponse,
          errorResponse: "Invalid Response");
    } on HttpException {
      return Failure(
          code: AppConst.noInternet, errorResponse: "No internet Available");
    } on FormatException {
      return Failure(
          code: AppConst.invalidFormat,
          errorResponse: "Please Mak sure your location is enabled");
    } catch (e) {
      return Failure(
          code: AppConst.unknownError, errorResponse: "Unknown error");
    }
  }
}
