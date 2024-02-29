import 'package:flutter_test/flutter_test.dart';
import 'package:foodcourt_task/src/modules/home/model/city_model.dart';
import 'package:foodcourt_task/src/modules/home/repository/local/city.dart';
import 'package:foodcourt_task/src/modules/home/viewModel/city_viewmodel.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Mock implementation of CitiesImpl
class MockCitiesImpl extends Mock implements CitiesImpl {}

// Mock implementation of SharedPreferences
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('CityViewModel Tests', () {
    late CityViewModel viewModel;
    late MockCitiesImpl mockRepository;
    late MockSharedPreferences mockSharedPreferences;

    setUp(() {
      mockRepository = MockCitiesImpl();
      mockSharedPreferences = MockSharedPreferences();
      viewModel = CityViewModel();
    });

    test('loadCities', () async {
      final List<CityModel> expectedCities = [
        CityModel(city: 'Lagos'),
        CityModel(city: 'Abuja'),
        // Add more cities as needed
      ];

      when(mockRepository.getCities()).thenAnswer((_) async => expectedCities);

      await viewModel.loadCities();

      expect(viewModel.cities, expectedCities);
    });

    test('loadPersistedData', () async {
      final List<CityModel> cities = [
        CityModel(city: 'Lagos'),
        CityModel(city: 'Abuja'),
        // Add more cities as needed
      ];

      final List<String> tempCityNames = cities.map((city) => city.city!).toList();

      when(mockSharedPreferences.getStringList('tempCities')).thenReturn(tempCityNames);

      viewModel.loadPersistedData();

      expect(viewModel.tempCities, cities);
    });

    test('savePersistedData', () async {
      final List<CityModel> tempCities = [
        CityModel(city: 'Lagos'),
        CityModel(city: 'Abuja'),
        // Add more cities as needed
      ];

      final List<String> tempCityNames = tempCities.map((city) => city.city!).toList();

      when(mockSharedPreferences.setStringList('tempCities', tempCityNames))
          .thenAnswer((_) async => true);

      viewModel.savePersistedData();

      // Verify that SharedPreferences method is called with correct arguments
      verify(mockSharedPreferences.setStringList('tempCities', tempCityNames));
    });

    // Add tests for addCityToCarousel, removeCityFromCarousel, and selectCity methods
    // Ensure to mock dependencies as needed and verify the expected behavior

  });
}
