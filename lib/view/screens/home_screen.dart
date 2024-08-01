import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/global/utils.dart';
import 'package:weather_app/provider/weather_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              height: height,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage((weatherProviderTrue.isDay)
                      ? weatherProviderTrue.sunnyDay
                      : weatherProviderTrue.night),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.account_circle_outlined,
                            size: 35,
                            color: Colors.white,
                          ),
                          Text(
                            weatherProviderTrue
                                .weatherModal!.locationModal.name,
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              weatherProviderFalse.favouriteCity(
                                weatherProviderTrue
                                    .weatherModal!.locationModal.name,
                                weatherProviderTrue
                                    .weatherModal!.currentModal.temp_c,
                                weatherProviderTrue
                                    .weatherModal!.currentModal.condition.text,
                                weatherProviderTrue
                                    .weatherModal!.currentModal.condition.icon,
                              );
                              Navigator.of(context).pushNamed('/fav');
                            },
                            child: const Icon(
                              Icons.favorite_border,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      TextField(
                        controller: txtSearch,
                        style: const TextStyle(color: Colors.white),
                        onSubmitted: (value) {
                          weatherProviderFalse.changeTheme();
                          weatherProviderFalse.searchWeather(value);
                        },
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: const TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.2,
                      ),
                      Text(
                        weatherProviderTrue.weatherModal!.locationModal.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        '${weatherProviderTrue.weatherModal!.currentModal.temp_c}°C',
                        style: const TextStyle(
                          fontSize: 55,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        weatherProviderTrue
                            .weatherModal!.currentModal.condition.text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.14,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: height * 0.25,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '24-Hour Forecast',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...List.generate(
                                    weatherProviderTrue
                                        .weatherModal!
                                        .forecastModal
                                        .forecastDay
                                        .first
                                        .hour
                                        .length,
                                    (index) {
                                      final hour = weatherProviderTrue
                                          .weatherModal!
                                          .forecastModal
                                          .forecastDay
                                          .first
                                          .hour[index];
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: height * 0.01,
                                          ),
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
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: height * 0.24,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 90,
                                    width: 170,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: (weatherProviderTrue.weatherModal!
                                                  .currentModal.is_day ==
                                              1)
                                          ? const Color(0xff4E7197)
                                              .withOpacity(0.8)
                                          : const Color(0xff223150)
                                              .withOpacity(0.8),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${weatherProviderTrue.weatherModal!.currentModal.wind_mph} mph',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          '${weatherProviderTrue.weatherModal!.currentModal.wind_kph} kph',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Container(
                                    height: height * 0.1,
                                    width: width * 0.43,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: (weatherProviderTrue.weatherModal!
                                                  .currentModal.is_day ==
                                              1)
                                          ? const Color(0xff4E7197)
                                              .withOpacity(0.8)
                                          : const Color(0xff223150)
                                              .withOpacity(0.8),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: weatherProviderTrue
                                                    .weatherModal!
                                                    .forecastModal
                                                    .forecastDay
                                                    .first
                                                    .astroModal
                                                    .sunrise
                                                    .split(" ")
                                                    .sublist(0, 1)
                                                    .join(" "),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: ' Sunrise',
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 20,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: weatherProviderTrue
                                                    .weatherModal!
                                                    .forecastModal
                                                    .forecastDay
                                                    .first
                                                    .astroModal
                                                    .sunset
                                                    .split(" ")
                                                    .sublist(0, 1)
                                                    .join(" "),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: ' Sunset',
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Container(
                                height: height * 0.22,
                                width: width * 0.45,
                                decoration: BoxDecoration(
                                    color: (weatherProviderTrue.weatherModal!
                                                .currentModal.is_day ==
                                            1)
                                        ? const Color(0xff4E7197)
                                            .withOpacity(0.8)
                                        : const Color(0xff223150)
                                            .withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 10,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Humidity',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            '${weatherProviderTrue.weatherModal!.currentModal.humidity}',
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * 0.003,
                                      ),
                                      const Divider(
                                        height: 0.2,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        height: height * 0.006,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'UV',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            '${weatherProviderTrue.weatherModal!.currentModal.uv}',
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * 0.0004,
                                      ),
                                      const Divider(
                                        height: 0.2,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        height: height * 0.0009,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Pressure',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            '${weatherProviderTrue.weatherModal!.currentModal.pressure_mb}',
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * 0.0005,
                                      ),
                                      const Divider(
                                        height: 0.2,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        height: height * 0.0005,
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Chance of rain',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            '45%',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * 0.0004,
                                      ),
                                      const Divider(
                                        height: 0.2,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        height: height * 0.0007,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Pressure in',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            '${weatherProviderTrue.weatherModal!.currentModal.pressure_in}',
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
