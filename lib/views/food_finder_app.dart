import 'package:flutter/material.dart';
import 'package:food_finder/models/venues_db.dart';
import 'package:food_finder/helpers/weather_checker.dart';
import 'package:food_finder/views/custom_grid_tile.dart';
import 'package:food_finder/views/custom_grid_view.dart';
import 'package:food_finder/views/map.dart';
import 'package:food_finder/views/top_bar.dart';
import 'package:provider/provider.dart';
import 'package:food_finder/providers/position_provider.dart';
import 'package:food_finder/providers/weather_provider.dart';
import 'dart:async';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 198, 219, 207))),
        home: Consumer2<PositionProvider, WeatherProvider>(
            builder: (context, positionProvider, weatherProvider, child) {
          if (positionProvider.positionKnown) {
            _weatherChecker.updateLocation(
                positionProvider.latitude, positionProvider.longitude);
          }
          return PlatformScaffold(
            appBar: const TopBar().build(context),
            body: SafeArea(
                child: bodyWidget(
                    10,
                    positionProvider.latitude,
                    positionProvider.longitude,
                    weatherProvider.isSunny(),
                    positionProvider.positionKnown)),
            bottomNavBar: bottomBar(),
          );
        }));
  }

  List<CustomGridTile> tiles(int max, double latitude, double longitude,
      bool isSunny, bool positionKnown) {
    return widget.venues
        .nearestTo(max: max, latitude: latitude, longitude: longitude)
        .map((venue) =>
            CustomGridTile(venue, isSunny, latitude, longitude, positionKnown))
        .toList();
  }

  //
  // Returns: A Platform native navigation bar
  PlatformNavBar bottomBar() {
    return PlatformNavBar(
      itemChanged: (int index) {
        setState(() {
          _currentTabIndex = index;
        });
      },
      currentIndex: _currentTabIndex,

      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.restaurant), label: 'Restaurants'),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
      ],
    );
  }

  Widget bodyWidget(int max, double latitude, double longitude, bool isSunny, bool positionKnown) {
    if (_currentTabIndex == 0) {
      return CustomGridView(
          tiles(30, latitude, longitude, isSunny, positionKnown));
    }
    return MapView(latitude, longitude, widget.venues, isSunny);
  }
}
