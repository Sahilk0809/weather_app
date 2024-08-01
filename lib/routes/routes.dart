import 'package:flutter/material.dart';
import 'package:weather_app/view/screens/favourite_screen.dart';
import 'package:weather_app/view/screens/forecast_details.dart';
import 'package:weather_app/view/screens/home_screen.dart';
import 'package:weather_app/view/screens/splash_screen.dart';

class MyRoutes{
  static Map<String, Widget Function(BuildContext)> myRoutes = {
    '/f' : (context) => const ForecastDetails(),
    '/' : (context) => const SplashScreen(),
    '/home' : (context) => const HomeScreen(),
    '/forecast' : (context) => const ForecastDetails(),
    '/fav' : (context) => const FavouriteScreen(),
  };
}