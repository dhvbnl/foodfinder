import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:food_finder/models/venues_db.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

var mapBox = 'https://api.mapbox.com/styles/v1/dhvbansal/clv8jhank00oh01ppctfecmvh.html?title=view&access_token=pk.eyJ1IjoiZGh2YmFuc2FsIiwiYSI6ImNsdjhqZnBxeDBrMHcya254cGtvajhycTAifQ.WN0eHO9lxwtu_otR_5Au-w';
var mapBoxReal = 'https://api.mapbox.com/styles/v1/dhvbansal/clv8jhank00oh01ppctfecmvh/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZGh2YmFuc2FsIiwiYSI6ImNsdjhqZnBxeDBrMHcya254cGtvajhycTAifQ.WN0eHO9lxwtu_otR_5Au-w';
var openStreet = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';


var apiKey = 'pk.eyJ1IjoiZGh2YmFuc2FsIiwiYSI6ImNsdjhqZnBxeDBrMHcya254cGtvajhycTAifQ.WN0eHO9lxwtu_otR_5Au-w';

class MapView extends StatelessWidget {
  final double _latitude;
  final double _longitude;
  final VenuesDB _venues;

  const MapView(this._latitude, this._longitude, this._venues, {super.key});

  @override
  Widget build(BuildContext context) {
    return crossPlatformMap();
  }

  /*Widget iosMap(){
    return PlatformMap(
      initialCameraPosition: CameraPosition(target: LatLng(_latitude, _longitude), zoom: 15),
      //markers: {Marker(markerId: MarkerId('home'), position: LatLng(_latitude, _longitude))},
      /*circles: {
        Circle(
          circleId: CircleId('curr'), 
          center: LatLng(_latitude, _longitude),
          radius: 30,
          strokeWidth: 3,
          fillColor: Color.fromARGB(125, 27, 76, 160)
        )
      },*/
      myLocationEnabled: true,

    ); 
  }*/

  Widget crossPlatformMap(){
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(_latitude, _longitude),
        initialZoom: 16,
        maxZoom: 20,
        minZoom: 13,


      ),
      children: [
        TileLayer(
          urlTemplate: 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/512/{z}/{x}/{y}@2x?access_token=$apiKey',
         userAgentPackageName: 'com.food_finder.app',
        ),
        MarkerLayer(
          markers: _venues.nearestTo(latitude: _latitude, longitude: _longitude).map(
            (venue) => Marker(point: LatLng(venue.latitude, venue.longitude), child: const Icon(Icons.menu_book))).toList()
        ),
        CurrentLocationLayer(),
        const RichAttributionWidget(
          attributions: [TextSourceAttribution('Mapbox, © OpenStreetMap')],
          )
      ],
    );
  } 
}