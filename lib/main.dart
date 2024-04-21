import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:food_finder/models/venues_db.dart';
import 'package:food_finder/providers/position_provider.dart';
import 'package:food_finder/providers/weather_provider.dart';
import 'package:food_finder/views/food_finder_app.dart';
import 'package:provider/provider.dart';


Future<VenuesDB> loadVenuesDB(String dataPath) async {
  return VenuesDB.initializeFromJson(await rootBundle.loadString(dataPath));
}

void main() {
  const dataPath = 'assets/venuesDetailed.json';
  WidgetsFlutterBinding.ensureInitialized();
  loadVenuesDB(dataPath).then((value) => runApp(
    MultiProvider(
      providers: [
       ChangeNotifierProvider<WeatherProvider>( create: (context) => WeatherProvider()),
       ChangeNotifierProvider<PositionProvider>( create: (context) => PositionProvider())
      ],
      child: FoodFinderApp(venues: value))));
}
