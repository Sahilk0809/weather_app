import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/weather_provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

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
            return Container(
              height: double.infinity,
              width: double.infinity,
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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.05,
                    ),
                    const Text(
                      'Favourite Cities',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: weatherProviderTrue.favouriteList.length,
                        itemBuilder: (context, index) {
                          final name = weatherProviderTrue.favouriteList[index]
                              .split('-')
                              .sublist(0, 1)
                              .join('-');
                          final status = weatherProviderTrue
                              .favouriteList[index]
                              .split('-')
                              .sublist(1, 2)
                              .join('-');
                          final temp = weatherProviderTrue.favouriteList[index]
                              .split('-')
                              .sublist(2, 3)
                              .join('-');
                          final icon = weatherProviderTrue.favouriteList[index]
                              .split('-')
                              .sublist(3, 4)
                              .join('-');
                          return Card(
                            color: Colors.transparent,
                            child: ListTile(
                              leading: Image.network('http:$icon'),
                              title: Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              trailing: Text(
                                status,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
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
