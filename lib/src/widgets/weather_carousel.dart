import 'package:flutter/material.dart';
import 'package:foodcourt_task/src/modules/home/viewModel/city_viewmodel.dart';
import 'package:foodcourt_task/src/widgets/weather_card.dart';
import 'package:provider/provider.dart';

class WeatherCarousel extends StatelessWidget {
  const WeatherCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    CityViewModel controller = context.watch<CityViewModel>();
    final PageController pageController = PageController(viewportFraction: 0.8);

    return Expanded(
      child: PageView.builder(
        controller: pageController,
        itemCount: controller.tempCities.length,
        itemBuilder: (context, index) {
          final city = controller.cities[index];
          return FutureBuilder(
            future: controller.loadWeatherCarousels(city.lng!, city.lat!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final weatherData = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: WeatherCard(
                    index: index,
                    city: city,
                    weatherData: weatherData,
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
