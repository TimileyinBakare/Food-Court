import 'package:flutter/material.dart';
import 'package:foodcourt_task/src/modules/home/viewModel/location_viewmodel.dart';
import 'package:provider/provider.dart';

import '../core/logger.dart';
import '../modules/home/viewModel/city_viewmodel.dart';

class WeatherSearch extends StatelessWidget {
  const WeatherSearch({super.key});

  @override
  Widget build(BuildContext context) {
    CityViewModel citycontrol = context.watch<CityViewModel>();
    LocationViewModel locatorcontrol = context.watch<LocationViewModel>();
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  _showBottomSheet(context, citycontrol, locatorcontrol);
                },
                child: const Text('Select City'),
              ),
              const Spacer(),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              logger.i('Using current location');
              locatorcontrol.getLocation();
            },
            child: const Text('Use Current Location'),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(
    BuildContext context,
    CityViewModel controller,
    LocationViewModel locatorcontrol,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select another City',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.cities.length,
                  itemBuilder: (BuildContext context, int index) {
                    final city = controller.cities[index];
                    return ListTile(
                      title: Text(city.city!),
                      onTap: () {
                        controller.selectCity(city);
                        locatorcontrol.setLatitude(double.parse(city.lat!));
                        locatorcontrol.setLongitude(double.parse(city.lng!));
                        logger.i("Long${city.lng!}");
                        logger.i("Lat${city.lat!}");
                        locatorcontrol.getWeatherReport();
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
