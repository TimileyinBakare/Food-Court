import 'package:flutter/material.dart';
import 'package:foodcourt_task/src/core/logger.dart';
import 'package:foodcourt_task/src/modules/home/model/city_model.dart';
import 'package:foodcourt_task/src/modules/home/model/location_model.dart';
import 'package:foodcourt_task/src/modules/home/viewModel/city_viewmodel.dart';
import 'package:provider/provider.dart';

class WeatherCard extends StatelessWidget {
  final CityModel city;
  final LocationModel weatherData;

  final int index;

  const WeatherCard({
    Key? key,
    required this.city,
    required this.weatherData,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CityViewModel controller = context.watch<CityViewModel>();

    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(137, 148, 134, 134)),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          color: Colors
              .transparent, 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                city.city!,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Temperature: ${weatherData.main!.temp}°C',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Feels Like: ${weatherData.main!.feelsLike}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Temp Max: ${weatherData.main!.tempMax}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              Text(
                ' Humidity: ${weatherData.main!.humidity}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Pressure: ${weatherData.main!.pressure}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Feels Like: ${weatherData.main!.tempMin}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Sea Level: ${weatherData.main!.seaLevel}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      controller.removeCityFromCarousel(index);
                      logger.i(index);
                    },
                    child: const Text('Remove'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.addCityToCarousel(city);
                      logger.i(index);
                    },
                    child: const Text('Add Location Widget'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
