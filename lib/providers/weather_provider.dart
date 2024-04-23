import 'package:flutter/material.dart';
import 'package:food_finder/helpers/weather_conditions.dart';

class WeatherProvider extends ChangeNotifier {
  int? tempInFarenheit = 0;
  WeatherCondition condition = WeatherCondition.unknown;
  bool gotUpdate = false;

  ///Updated weather information from parameters
  /// Parameters:
  ///  - newTempFarenheit: new temperature in Farenheit
  ///  - newCondition: new weather condition
  updateWeather(int? newTempFarenheit, WeatherCondition newCondition){
    gotUpdate = true;
    tempInFarenheit = newTempFarenheit;
    condition = newCondition;
    notifyListeners();
  }

  //Returns: if current condition is sunny or not
  isSunny(){
    return condition == WeatherCondition.sunny;
  }
}