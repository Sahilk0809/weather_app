import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/helper/api_helper.dart';
import 'package:weather_app/modal/weather_modal.dart';

class WeatherProvider extends ChangeNotifier {
  ApiHelper apiHelper = ApiHelper();
  WeatherModal? weatherModal;
  String search = 'surat';
  List<String> favouriteList = [];
  bool isDay = true;
  String sunnyDay = 'https://i.makeagif.com/media/4-26-2017/eTBCqD.gif';
  String rainy =
      'https://31.media.tumblr.com/tumblr_m8rnd3NZJE1rdeykbo1_400.gif';
  String night = 'https://media.tenor.com/7SyjVdzFqmMAAAAC/stars-night.gif';

  Future<WeatherModal?> fetchDataFromApi() async {
    final json = await apiHelper.fetchApi(search);
    weatherModal = WeatherModal.fromJson(json);
    return weatherModal;
  }

  void searchWeather(String value) {
    value.toLowerCase();
    search = value;
    notifyListeners();
  }

  Future<void> favouriteCity(String name, double temp, String condition, String icon) async {
    favouriteList.add('$name-$temp-$condition-$icon');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList('weather', favouriteList);
  }

  Future<void> getFavouriteCity() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    favouriteList = sharedPreferences.getStringList('weather') ?? <String>[];
    print(favouriteList);
    notifyListeners();
  }

  void changeTheme() {
    if (weatherModal!.currentModal.is_day == 1) {
      isDay = true;
      notifyListeners();
    } else {
      isDay = false;
      notifyListeners();
    }
  }

  WeatherProvider() {
    getFavouriteCity();
    Timer(
      const Duration(seconds: 3),
      () {
        changeTheme();
      },
    );
  }
}
