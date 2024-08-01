import 'package:flutter/material.dart';
import 'package:weather_app/view/screens/favourite_screen.dart';
import 'package:weather_app/view/screens/home_screen.dart';
import 'package:weather_app/view/screens/splash_screen.dart';

class MyRoutes{
  static Map<String, Widget Function(BuildContext)> myRoutes = {
    '/' : (context) => const SplashScreen(),
    '/home' : (context) => const HomeScreen(),
    '/fav' : (context) => const FavouriteScreen(),
  };
}