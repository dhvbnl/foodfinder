import 'dart:convert';
import 'package:food_finder/helpers/weather_conditions.dart';
import 'package:food_finder/providers/weather_provider.dart';
import 'package:http/http.dart' as http;

class WeatherChecker {
  final WeatherProvider weatherProvider;

  var _latitude = 47.96649; 
  var _longitude = -122.34318;

  WeatherChecker(this.weatherProvider);

  fetchAndUpdateCurrentWeather() async {
    var client = http.Client();
    try {
      final gridResponse = await client.get(
          Uri.parse('https://api.weather.gov/points/$_latitude,$_longitude'));
      final gridParsed = (jsonDecode(gridResponse.body));
      final String? forecastURL = gridParsed['properties']?['forecast'];
      if (forecastURL == null) {
        // do nothing
      } else {
        final weatherResponse = await client.get(Uri.parse(forecastURL));
        final weatherParsed = jsonDecode(weatherResponse.body);
        final currentPeriod = weatherParsed['properties']?['periods']?[0];
        if (currentPeriod != null) {
          final temperature = currentPeriod['temperature'];
          final shortForecast = currentPeriod['shortForecast'];
          print(
              'Got the weather at ${DateTime.now()}. $temperature F and $shortForecast');
          if (temperature != null && shortForecast != null) {
            final condition = _shortForecastToCondition(shortForecast);
            print('temperature: $temperature, condition: $condition');
            weatherProvider.updateWeather(temperature, condition);
          } else{
            weatherProvider.updateWeather(null, WeatherCondition.unknown);
          }
        }
      }
    } catch (_) {
      // (optional): Find a way to have the UI let the user know that we haven't been able to update data successfully
    } finally {
      client.close();
    }
  }

  WeatherCondition _shortForecastToCondition(String shortForecast) {
    final lowercased = shortForecast.toLowerCase();
    if (lowercased.startsWith('rain')) return WeatherCondition.rainy;
    if (lowercased.startsWith('sun') || lowercased.startsWith('partly')) {
      return WeatherCondition.sunny;
    }
    return WeatherCondition.gloomy;
  }

  void updateLocation(double latitude, double longitude){
    _latitude = latitude;
    _longitude = longitude;
  }
}
