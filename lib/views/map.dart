import 'package:flutter/material.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';

class MapView extends StatelessWidget {
  final double _latitude;
  final double _longitude;

  const MapView(this._latitude, this._longitude, {super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformMap(
      initialCameraPosition: CameraPosition(target: LatLng(_latitude, _longitude), zoom: 15),
    );
  }
}