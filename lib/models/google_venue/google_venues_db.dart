import 'dart:convert';

import 'package:food_finder/models/google_venue/google_venue.dart';

class GoogleVenuesDB {
  final List<GoogleVenue> _googleVenue;

  List<GoogleVenue> get all {
    return List<GoogleVenue>.from(_googleVenue, growable: false);
  }

  GoogleVenuesDB.initializeFromJson(String jsonString)
      : _googleVenue = _decodeVenueListJson(jsonString);

  static List<GoogleVenue> _decodeVenueListJson(String jsonString) {
    final listMap = jsonDecode(jsonString);
    final theList = (listMap[0]).map((element) {
      return GoogleVenue.fromJson(element);
    }).toList();
    return theList; 
  }
}
