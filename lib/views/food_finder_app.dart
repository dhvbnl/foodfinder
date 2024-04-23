import 'package:flutter/material.dart';
import 'package:food_finder/models/venues_db.dart';
import 'package:food_finder/helpers/weather_checker.dart';
import 'package:food_finder/views/custom_grid_tile.dart';
import 'package:food_finder/views/custom_grid_view.dart';
import 'package:food_finder/views/map_view.dart';
import 'package:food_finder/views/top_bar.dart';
import 'package:provider/provider.dart';
import 'package:food_finder/providers/position_provider.dart';
import 'package:food_finder/providers/weather_provider.dart';
import 'dart:async';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class FoodFinderApp extends StatefulWidget {
  final VenuesDB venues;

  const FoodFinderApp({
    super.key,
    required this.venues,
  });

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
    _weatherChecker = WeatherChecker(
      Provider.of<WeatherProvider>(context, listen: false),
    );
    _weatherChecker.fetchAndUpdateCurrentWeather();

    _checkerTimer = Timer.periodic(
      const Duration(seconds: 60),
      (timer) => _weatherChecker.fetchAndUpdateCurrentWeather(),
    );
  }

  @override
  dispose() {
    super.dispose();
    _checkerTimer.cancel();
  }

  /// Builds the food_finder view as well as establishes the theme
  /// Parameters:
  ///  - context: context for build
  /// Returns: Widget of whole app view
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //generates theme from light green color
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 198, 219, 207),
        ),
      ),
      //main view of app
      home: Consumer2<PositionProvider, WeatherProvider>(
        builder: (
          context,
          positionProvider,
          weatherProvider,
          child,
        ) {
          //update weatherProvider is position is known
          if (positionProvider.positionKnown) {
            _weatherChecker.updateLocation(
              positionProvider.latitude,
              positionProvider.longitude,
            );
          }
          //cross platform scaffold
          return PlatformScaffold(
            appBar: const TopBar().build(context),
            body: SafeArea(
              child: bodyWidget(
                30,
                positionProvider,
                weatherProvider.isSunny(),
                positionProvider.positionKnown,
              ),
            ),
            bottomNavBar: bottomBar(),
          );
        },
      ),
    );
  }

  /// Makes tiles sorted based on customSort function
  /// Parameters:
  ///  - max: number of tiles for gridView
  ///  - latitude: current latitude
  ///  - longitude: current longituded
  ///  - isSunny: if current weather is weatherCondition.sunny
  ///  - positionKnown: if latitude and longitude is updated
  /// Returns: List of all tiles in order of the custom function
  List<CustomGridTile> tiles(
    int max,
    PositionProvider positionProvider,
    bool isSunny,
    bool locationFound,
  ) {
    return widget.venues
        .customSort(
          max: max,
          latitude: positionProvider.latitude,
          longitude: positionProvider.longitude,
          isSunny: isSunny,
        )
        .map(
          (venue) => CustomGridTile(
            venue: venue,
            isSunny: isSunny,
            positionProvider: positionProvider,
          ),
        )
        .toList();
  }

  /// Builds a platform native navigation bar with two tabs: restaurant and map
  /// Returns: A Platform native navigation bar
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

  /// Builds a widget depending on which tab is open
  /// Parameters:
  ///  - max: number of tiles for gridView
  ///  - latitude: current latitude
  ///  - longitude: current longituded
  ///  - isSunny: if current weather is weatherCondition.sunny
  ///  - positionKnown: if latitude and longitude is updated
  /// Returns: view of either a grid view with tiles or the map view
  Widget bodyWidget(
    int max,
    PositionProvider positionProvider,
    bool isSunny,
    bool positionKnown,
  ) {
    if (_currentTabIndex == 0) {
      return CustomGridView(
        tiles: tiles(
          max,
          positionProvider,
          isSunny,
          positionKnown,
        ),
      );
    }
    return MapView(
      positionProvider: positionProvider,
      venues: widget.venues,
      isSunny: isSunny,
    );
  }
}
