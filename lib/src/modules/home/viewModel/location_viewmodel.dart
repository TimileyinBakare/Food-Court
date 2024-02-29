import 'package:flutter/material.dart';
import 'package:foodcourt_task/src/modules/home/model/location_model.dart';
import 'package:foodcourt_task/src/modules/home/model/location_model_error.dart';
import 'package:foodcourt_task/src/modules/home/repository/api/weather_repo_impl.dart';
import 'package:foodcourt_task/src/modules/home/repository/app_status.dart';

import '../../../core/logger.dart';

class LocationViewModel extends ChangeNotifier {
  LocationViewModel() {
    getWeatherReport();
  }
  double? _longitude = 3.3841;
  double? _latitude = 6.4550;

  bool _loading = false;
  UserError? _userError;

  List<LocationModel> _locationListModel = [];

  List<LocationModel> get getLocationListModel => _locationListModel;

  UserError? get userError => _userError;

  bool get loading => _loading;

  double? get longitude => _longitude;

  double? get latitude => _latitude;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setLatitude(double lat) {
    _latitude = lat;
    notifyListeners();
  }

  setLongitude(double lon) {
    _longitude = lon;
    notifyListeners();
  }

  setError(UserError userError) {
    _userError = userError;
  }

  setWeatherListModel(List<LocationModel> locatioListModel) {
    _locationListModel = locatioListModel;
  }

  getLocation() async {
    setLoading(true);
    //Injecting our dependencies
    WeatherReportImpl getLocation = WeatherReportImpl();
    var data = await getLocation.getCurrentLocation();
    setLatitude(data!.latitude);
    setLongitude(data.longitude);
    notifyListeners();
    // logging the longitude and latitude
    logger.i(data.longitude.toString());
    logger.i(data.latitude.toString());
    setLoading(false);
    getWeatherReport();
  }

  getWeatherReport() async {
    setLoading(true);
    WeatherReportImpl services = WeatherReportImpl();
    var data = await services.getWeatherReports(
      lon: _longitude.toString(),
      lat: latitude.toString(),
    );
    logger.i(data.toString());

    // if response is bool to Success object set the value of the list
    if (data is Success) {
      setWeatherListModel([data.response as LocationModel]);
    }
    // else false throw the object fails error
    if (data is Failure) {
      UserError? userError = UserError(
        code: data.code.toString(),
        message: data.errorResponse,
      );
      setError(userError);
    }
    setLoading(false);
    notifyListeners();
  }
}
