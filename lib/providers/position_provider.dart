import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PositionProvider extends ChangeNotifier {
  double latitude = 0;
  double longitude = 0;
  bool locationFound = false;

  late final Timer _timer;

  PositionProvider() {
    print('called');
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => _determinePosition()
          .then((position) => 
            _updatePosition(position), onError: (error) => _locationNotFound()),
    );
  }

  @override
  dispose() {
    super.dispose();
    _timer.cancel();
  }

  void _locationNotFound(){
    locationFound = false;
  }

  void _updatePosition(Position currentPosition) {
    latitude = currentPosition.latitude;
    longitude = currentPosition.longitude;
    notifyListeners();
  }

  bool get positionKnown {
    return locationFound;
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
