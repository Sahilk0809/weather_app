import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/helper/api_helper.dart';
import 'package:weather_app/modal/weather_modal.dart';

import '../global/utils.dart';

class WeatherProvider extends ChangeNotifier {
  ApiHelper apiHelper = ApiHelper();
  WeatherModal? weatherModal;
  String search = 'surat';
  List<String> favouriteList = [];
  bool isDay = true;
  bool isRain = false;
  String sunnyDay = 'https://i.makeagif.com/media/4-26-2017/eTBCqD.gif';
  String rainy =
      'https://cdn.pixabay.com/animation/2024/04/03/23/48/23-48-16-122_512.gif';
  String nightRain =
      'https://gifdb.com/images/high/rain-at-night-dark-aesthetic-unpfpvs7pe8tkzol.gif';
  String night = 'https://media.tenor.com/7SyjVdzFqmMAAAAC/stars-night.gif';
  String month = '';

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

  Future<void> favouriteCity(
      String name, double temp, String condition, String icon) async {
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

  void time() {
    switch (date.month) {
      case 1:
        month = 'Jan';
        notifyListeners();
        break;
      case 2:
        month = 'Feb';
        notifyListeners();
        notifyListeners();
        break;
      case 3:
        month = 'Mar';
        notifyListeners();
        break;
      case 4:
        month = 'Apr';
        notifyListeners();
        break;
      case 5:
        month = 'May';
        notifyListeners();
        break;
      case 6:
        month = 'Jun';
        notifyListeners();
        break;
      case 7:
        month = 'Jul';
        notifyListeners();
        break;
      case 8:
        month = 'Aug';
        notifyListeners();
        break;
      case 9:
        month = 'Sep';
        notifyListeners();
        break;
      case 10:
        month = 'Oct';
        notifyListeners();
        break;
      case 11:
        month = 'Nov';
        notifyListeners();
        break;
      case 12:
        month = 'Dec';
        notifyListeners();
        break;
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
