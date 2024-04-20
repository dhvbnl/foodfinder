import 'package:flutter/material.dart';
import 'package:food_finder/models/venues_db.dart';
import 'package:food_finder/helpers/weather_checker.dart';
import 'package:food_finder/views/custom_grid_tile.dart';
import 'package:food_finder/views/custom_grid_view.dart';
import 'package:food_finder/views/top_bar.dart';
import 'package:provider/provider.dart';
import 'package:food_finder/providers/position_provider.dart';
import 'package:food_finder/providers/weather_provider.dart';
import 'dart:async';

class FoodFinderApp extends StatefulWidget {
  final VenuesDB venues;

  const FoodFinderApp({super.key, required this.venues});

  @override
  State<FoodFinderApp> createState() => _FoodFinderAppState();
}

class _FoodFinderAppState extends State<FoodFinderApp> {
  late final Timer _checkerTimer;
  late final WeatherChecker _weatherChecker;
  var _currentTabIndex = 0;

  @override
  initState() {
    super.initState();
    _weatherChecker =
        WeatherChecker(Provider.of<WeatherProvider>(context, listen: false));
    _weatherChecker.fetchAndUpdateCurrentWeather();

    _checkerTimer = Timer.periodic(const Duration(seconds: 60),
        (timer) => _weatherChecker.fetchAndUpdateCurrentWeather());
  }

  @override
  dispose() {
    super.dispose();
    _checkerTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Consumer2<PositionProvider, WeatherProvider>(
                builder: (context, positionProvider, weatherProvider, child) {
        if (positionProvider.positionKnown) {
          _weatherChecker.updateLocation(positionProvider.latitude, positionProvider.longitude);
        }
        return Scaffold(
          appBar: const TopBar().build(context), 
          body: SafeArea(child: CustomGridView(tiles(30, positionProvider.latitude, positionProvider.longitude, weatherProvider.isSunny()))),
          bottomNavigationBar: bottomBar(),
        );
      })
    );
  }

  List<CustomGridTile> tiles(int max, double latitude, double longitude, bool isSunny){
    return widget.venues.nearestTo(max: max, latitude: latitude, longitude: longitude)
      .map((venue) => CustomGridTile(venue, isSunny, latitude, longitude)).toList();
  }

  Widget bottomBar(){
    return NavigationBar(
        onDestinationSelected: (int index){
          setState((){ // Executes code and then causes widget to re-build()
            _currentTabIndex = index;
          });
        },
        //indicatorColor: theme.primaryColor,
        selectedIndex: _currentTabIndex,

        // This defines what is in the nav bar 
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.restaurant), label: 'Restaurants'),
          NavigationDestination(icon: Icon(Icons.map), label: 'Map'),
        ],
      );
  }
}
