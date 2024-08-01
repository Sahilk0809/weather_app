import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/global/utils.dart';

import '../../provider/weather_provider.dart';

class ForecastDetails extends StatelessWidget {
  const ForecastDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var weatherProviderTrue =
        Provider.of<WeatherProvider>(context, listen: true);
    var weatherProviderFalse =
        Provider.of<WeatherProvider>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: weatherProviderFalse.fetchDataFromApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            weatherProviderFalse.time();
            return Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    (weatherProviderTrue.isDay)
                        ? (weatherProviderTrue.weatherModal!.forecastModal
                                    .forecastDay.first.day.chanceOfRain >
                                40)
                            ? weatherProviderTrue.rainy
                            : weatherProviderTrue.sunnyDay
                        : (weatherProviderTrue.weatherModal!.forecastModal
                                    .forecastDay.first.day.chanceOfRain >
                                40)
                            ? weatherProviderTrue.nightRain
                            : weatherProviderTrue.night,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),
                    const Text(
                      'Forecast Report',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Today',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${date.day} ${weatherProviderTrue.month} ${date.year}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            ...List.generate(
                              weatherProviderTrue.weatherModal!.forecastModal
                                  .forecastDay.first.hour.length,
                              (index) {
                                final hour = weatherProviderTrue
                                    .weatherModal!
                                    .forecastModal
                                    .forecastDay
                                    .first
                                    .hour[index];
                                return Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Text(
                                        hour.time
                                            .split(' ')
                                            .sublist(1, 2)
                                            .join(' '),
                                        style: const TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Image.network(
                                        'http:${hour.hourConditionModal.icon}'),
                                    Text(
                                      hour.temp_c.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.035,
                    ),
                    const Text(
                      'Next 3 days forecast',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      height: height * 0.13,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${weatherProviderTrue.month} 1',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${weatherProviderTrue.weatherModal!.forecastModal.forecastDay.first.hour.first.temp_c}°C',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image.network(
                              'http:${weatherProviderTrue.weatherModal!.currentModal.condition.icon}'),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      height: height * 0.13,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${weatherProviderTrue.month} 2',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${weatherProviderTrue.weatherModal!.forecastModal.forecastDay.first.day.maxtemp_c}°C',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image.network(
                              'http:${weatherProviderTrue.weatherModal!.currentModal.condition.icon}'),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      height: height * 0.13,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${weatherProviderTrue.month} 3',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${weatherProviderTrue.weatherModal!.forecastModal.forecastDay.first.day.mintemp_c}°C',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image.network(
                              'http:${weatherProviderTrue.weatherModal!.currentModal.condition.icon}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
