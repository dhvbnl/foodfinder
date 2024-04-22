import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:food_finder/models/venue.dart';
import 'package:food_finder/models/venues_db.dart';
import 'package:food_finder/providers/position_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:food_finder/helpers/url.dart';
import 'package:maps_launcher/maps_launcher.dart';

var apiKey =
    'pk.eyJ1IjoiZGh2YmFuc2FsIiwiYSI6ImNsdjhqZnBxeDBrMHcya254cGtvajhycTAifQ.WN0eHO9lxwtu_otR_5Au-w';

class MapView extends StatelessWidget {
  final PositionProvider positionProvider;
  final VenuesDB venues;
  final bool isSunny;

  final _positionStream =
      const LocationMarkerDataStreamFactory().fromGeolocatorPositionStream(
    stream: Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.medium,
        distanceFilter: 50,
        timeLimit: Duration(minutes: 1),
      ),
    ),
  );

  MapView({
    required this.positionProvider,
    required this.venues,
    required this.isSunny,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return crossPlatformMap(context);
  }

  Widget crossPlatformMap(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(
          positionProvider.latitude,
          positionProvider.longitude,
        ),
        initialZoom: 15,
        maxZoom: 19,
        minZoom: 13,
      ),
      children: [
        mapBoxOverlay(),
        MarkerClusterLayerWidget(
          options: MarkerClusterLayerOptions(
            maxClusterRadius: 60,
            size: const Size(40, 40),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(50),
            maxZoom: 15,
            markers: venues
                .nearestTo(
                  latitude: positionProvider.latitude,
                  longitude: positionProvider.latitude,
                )
                .map(
                  (venue) => Marker(
                    point: LatLng(
                      venue.latitude,
                      venue.longitude,
                    ),
                    child: locationButton(context, venue),
                  ),
                )
                .toList(),
            builder: (context, markers) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.secondary),
                child: Center(
                  child: Text(
                    markers.length.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        CurrentLocationLayer(
          positionStream: _positionStream,
        ),
        mapBoxAttribution()
      ],
    );
  }

  TileLayer mapBoxOverlay() {
    return TileLayer(
      urlTemplate:
          'https://api.mapbox.com/styles/v1/mapbox/streets-v12/tiles/512/{z}/{x}/{y}@2x?access_token=$apiKey',
      userAgentPackageName: 'com.food_finder.app',
    );
  }

  DefaultTextStyle mapBoxAttribution() {
    return const DefaultTextStyle(
      style: TextStyle(
        fontSize: 15,
        color: Colors.black,
      ),
      child: RichAttributionWidget(
        attributions: [
          TextSourceAttribution(
            'Mapbox, © OpenStreetMap',
          ),
          TextSourceAttribution(
            'Restaurant Data from Google Maps',
          ),
        ],
      ),
    );
  }

  Widget locationButton(BuildContext context, Venue venue) {
    var locationColor = Theme.of(context).primaryColor;
    if (isSunny && !venue.hasPatio) {
      locationColor = const Color.fromARGB(255, 172, 171, 171);
    }
    return GestureDetector(
      onTapDown: (tapDetails) => openPlacePage(context, tapDetails, venue),
      child: Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
            color: locationColor.withOpacity(0.8),
            shape: BoxShape.circle,
            border: Border.all(
              width: 2,
              color: locationColor,
            )),
      ),
    );
  }

  openPlacePage(BuildContext context, TapDownDetails tapDetails, Venue venue) {
    final offset = tapDetails.globalPosition;
    List<PopupMenuEntry<int>> menu = [];
    menu.add(
      PopupMenuItem(
        value: 1,
        child: Text(
          venue.name,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
    var address = venue.fulladdress;
    menu.add(
      PopupMenuItem(
        value: 2,
        onTap: () => MapsLauncher.launchQuery(address),
        child: const Text('Directions'),
      ),
    );
    var website = venue.website;
    if (website != null) {
      menu.add(
        PopupMenuItem(
          value: 2,
          onTap: () => Url.openUrl(website),
          child: const Text('Website'),
        ),
      );
    }
    var phone = venue.phone;
    if (phone != null) {
      menu.add(
        PopupMenuItem(
          value: 2,
          onTap: () => Url.openUrl('tel: $phone'),
          child: const Text('Call'),
        ),
      );
    }

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy,
        MediaQuery.of(context).size.width - offset.dx,
        MediaQuery.of(context).size.height - offset.dy,
      ),
      items: menu,
    );
  }
}
