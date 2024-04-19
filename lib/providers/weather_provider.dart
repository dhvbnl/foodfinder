import 'package:flutter/material.dart';
import 'package:food_finder/helpers/weather_conditions.dart';

class WeatherProvider extends ChangeNotifier {
  int? tempInFarenheit = 0;
  WeatherCondition condition = WeatherCondition.unknown;
  bool gotUpdate = false;

  updateWeather(int? newTempFarenheit, WeatherCondition newCondition){
    gotUpdate = true;
    tempInFarenheit = newTempFarenheit;
    condition = newCondition;
    notifyListeners();
  }
}