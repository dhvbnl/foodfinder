import 'package:food_finder/models/google_venue/nearby_venue.dart';

class Venues {
  List<NearbyVenue>? nearbyVenue;

  Venues({List<NearbyVenue>? nearbyVenue}) {
    if (nearbyVenue != null) {
      nearbyVenue = nearbyVenue;
    }
  }

  Venues.fromJson(Map<String, dynamic> json) {
    if (json['places'] != null) {
      nearbyVenue = <NearbyVenue>[];
      json['places'].forEach((v) {
        nearbyVenue!.add(NearbyVenue.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (nearbyVenue != null) {
      data['places'] = nearbyVenue!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
