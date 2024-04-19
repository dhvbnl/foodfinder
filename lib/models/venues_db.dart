import 'dart:convert';

import 'package:food_finder/models/venue.dart';


class VenuesDB{
  final List<Venue> _venues;

  List<Venue> get all{
    return List<Venue>.from(_venues, growable: false);
  }

  nearestTo({int max = 999, required double latitude, required double longitude}){
    _venues.sort((v1, v2) => 
      v1.distanceFrom(latitude: latitude, longitude: longitude).compareTo(v2.distanceFrom(latitude: latitude, longitude: longitude))
    );
    return _venues.take(max);
  }


  VenuesDB.initializeFromJson(String jsonString) : _venues = _decodeVenueListJson(jsonString);

  static List<Venue> _decodeVenueListJson(String jsonString){
    final listMap = jsonDecode(jsonString);
    final theList = (listMap as List).map( (element) {
      return Venue.fromJson(element);
    }).toList();
    return theList;
  }

}