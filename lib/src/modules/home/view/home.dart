import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:foodcourt_task/src/utils/assets.dart';
import 'package:foodcourt_task/src/widgets/weather_carousel.dart';
import 'package:provider/provider.dart';

import '../../../widgets/weather_search.dart';
import '../viewModel/location_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocationViewModel controller = context.watch<LocationViewModel>();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.backgroudImage),
                fit: BoxFit
                    .cover, // Ensure the image covers the entire background
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 120),
            child: _body(controller),
          ),
        ],
      ),
    );
  }

  Widget _body(LocationViewModel controller) {
    if (controller.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (controller.userError != null) {
      return Center(
        child: Bounce(
          child: Text(controller.userError!.message.toString()),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                controller.getLocationListModel.first.name!,
                style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '${controller.getLocationListModel.first.main!.temp}°C',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Feels Like: ${controller.getLocationListModel.first.main!.feelsLike}°C',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              Text(
                'Humidity: ${controller.getLocationListModel.first.main!.humidity}%',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              // Add other details here as needed
            ],
          ),
        ),
        const WeatherCarousel(),
        const WeatherSearch(),
      ],
    );
  }
}
