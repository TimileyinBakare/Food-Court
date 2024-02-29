import 'package:flutter/material.dart';
import 'package:foodcourt_task/src/modules/home/model/city_model.dart';
import 'package:foodcourt_task/src/modules/home/model/location_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/local/city.dart';

class CityViewModel extends ChangeNotifier {
  final CitiesImpl _repository = CitiesImpl();
  List<CityModel> cities = [];
  List<CityModel> tempCities = [];
  CityModel? selectedCity;

  CityViewModel() {
    loadCities();
    // Load persisted data on initialization
    loadPersistedData();
  }

  Future<void> loadCities() async {
    cities = await _repository.getCities();
    notifyListeners();
  }

  void loadPersistedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? tempCityNames = prefs.getStringList('tempCities');
    if (tempCityNames != null) {
      tempCities = tempCityNames.map((cityName) {
        return cities.firstWhere((city) => city.city! == cityName);
      }).toList();
    }

    if (tempCities.length < 3) {
      for (int i = tempCities.length; i < 3; i++) {
        tempCities.add(cities[i % cities.length]);
      }
    }

    notifyListeners();
  }

  void savePersistedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tempCityNames = tempCities.map((city) => city.city!).toList();
    prefs.setStringList('tempCities', tempCityNames);
  }

  Future<LocationModel?> loadWeatherCarousels(String lon, String lat) async {
    return await _repository.getCarouselReports(lon: lon, lat: lat);
  }

  void selectCity(CityModel? city) {
    selectedCity = city;
    notifyListeners();
  }

  void addCityToCarousel(CityModel city) {
    if (tempCities.contains(city)) {
      int startIndex = tempCities.indexOf(city) + 1;
      bool added = false;
      for (int i = startIndex; i < cities.length; i++) {
        if (!tempCities.contains(cities[i])) {
          tempCities.add(cities[i]);
          added = true;
          break;
        }
      }
      if (!added) {
        return;
      }
    } else {
      tempCities.add(city);
    }
    savePersistedData();
    notifyListeners();
  }

  void removeCityFromCarousel(int index) {
    tempCities.removeAt(index);
    savePersistedData();
    notifyListeners();
  }
}
