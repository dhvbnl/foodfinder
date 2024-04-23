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
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

//API Key to get access to Mapbox maps
var mapboxApiKey =
    'pk.eyJ1IjoiZGh2YmFuc2FsIiwiYSI6ImNsdjhqZnBxeDBrMHcya254cGtvajhycTAifQ.WN0eHO9lxwtu_otR_5Au-w';

//Creates a map using flutter_map and associated packages
class MapView extends StatelessWidget {
  final PositionProvider positionProvider;
  final VenuesDB venues;
  final bool isSunny;

  //creates a positionStream for currentLocation marker on map
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

  /// Builds the flupper map with overlays
  /// Parameters:
  ///  - context: context for build
  /// Returns: FlutterMap widget centered around current location
  @override
  Widget build(BuildContext context) {
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
        markerWithClusters(context),
        CurrentLocationLayer(
          positionStream: _positionStream,
        ),
        mapBoxAttribution()
      ],
    );
  }

  /// Builds the Food_finder view as well as establishes the theme
  /// Parameters:
  ///  - context: context for build
  /// Returns: Widget of whole app view
  TileLayer mapBoxOverlay() {
    return TileLayer(
      urlTemplate:
          'https://api.mapbox.com/styles/v1/mapbox/light-v11/tiles/512/{z}/{x}/{y}@2x?access_token=$mapboxApiKey',
      userAgentPackageName: 'com.food_finder.app',
      tileProvider: CancellableNetworkTileProvider(),
    );
  }

  /// Forms markers with clustering depending on zoom
  /// Parameters:
  ///  - context: context for build
  /// Returns: MarkerClusterLayerWidget with constants for shapes
  MarkerClusterLayerWidget markerWithClusters(BuildContext context) {
    return MarkerClusterLayerWidget(
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
    );
  }

  /// Creates attribution for Map
  /// Returns: DefaultTextStyle with RichAttributionWidget with attributes
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

  /// Forms marker with clustering depending on zoom
  /// Parameters:
  ///  - context: context for build
  ///  - venue: Venue for menu
  /// Returns: GestureDetector shpaed as a circle with path to popup menu
  GestureDetector locationButton(BuildContext context, Venue venue) {
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

  /// Opens menu with various information of provided venue
  /// Parameters:
  ///  - context: context for build
  ///  - tapDetails: location of tap
  ///  - venue: Venue for menu
  void openPlacePage(
      BuildContext context, TapDownDetails tapDetails, Venue venue) {
    final offset = tapDetails.globalPosition;
    List<PopupMenuEntry<int>> menu = [];
    //adds name of venue
    menu.add(
      PopupMenuItem(
        value: 1,
        child: Text(
          venue.name,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
    menu.add(const PopupMenuDivider(height: 2));
    //adds address of venue
    var address = venue.fulladdress;
    menu.add(
      PopupMenuItem(
        value: 2,
        onTap: () => MapsLauncher.launchQuery(address).ignore(),
        child: const Text('Directions'),
      ),
    );
    //adds website of venue if exists
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
    //adds phone of venue if exists
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

    //opens context menu
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
