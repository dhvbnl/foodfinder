import 'package:food_finder/helpers/haversine.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:math';

part 'venue.g.dart';

// See documentation here https://docs.flutter.dev/data-and-backend/serialization/json#creating-model-classes-the-json_serializable-way
// After changing this class, it is essential to run `dart run build_runner build --delete-conflicting-outputs` from the root of the project.

//saves data for a venue used to populate view information
@JsonSerializable()
class Venue {
  Venue({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.hasPatio,
    required this.website,
    required this.reviewCount,
    required this.averageRating,
    required this.phone,
    required this.description,
    required this.fulladdress,
  });

  final String name;
  final double latitude;
  final double longitude;
  final String? website;
  final int reviewCount;
  final double averageRating;
  final String? phone;
  final String? description;
  final String fulladdress;

  @JsonKey(name: 'has_patio')
  final bool hasPatio;

  //creates venue from Json
  factory Venue.fromJson(Map<String, dynamic> json) => _$VenueFromJson(json);

  //converts venue to json
  Map<String, dynamic> toJson() => _$VenueToJson(this);

  /// Finds distance between two coordinates using basic geometry
  /// Parameters:
  ///  - latitude: latitude for current location
  ///  - longitude: longitude for current location
  /// Returns: relative distance between locations
  double distanceFrom({
    required double latitude,
    required double longitude,
  }) {
    return sqrt(_squared(this.latitude - latitude) +
        _squared(this.longitude - longitude));
  }

  /// Finds distance between two coordinates using the haversine formula
  /// Parameters:
  ///  - latitude: latitude for current location
  ///  - longitude: longitude for current location
  /// Returns: distance in miles between locations
  double haversineDistanceFrom({
    required double latitude,
    required double longitude,
  }) {
    return Haversine.haversine(
        this.latitude, this.longitude, latitude, longitude);
  }

  /// Creates a power ranking score for a venue based on constant factors
  /// Parameters:
  ///  - latitude: latitude for current location
  ///  - longitude: longitude for current location
  ///  - ratingFactor: increase score by 'ratingFactor' for every star
  ///  - distanceFactor: decreases score by 'distanceFactor' for every mile
  ///  - patioFactor: increases score by 'paioFactor' is it's sunny and venue has a patio
  ///  - reviewCountFactor: increases score by 'reviewCountFactor' for every review
  ///  - isSunny: enbales patioFactor mattering
  /// Returns: overall power ranking based on factors
  double powerRanking({
    required double latitude,
    required double longitude,
    double ratingFactor = 2.5,
    double distanceFactor = 4,
    double patioFactor = 2.5,
    double reviewCountFactor = 0.0003,
    bool isSunny = false,
  }) {
    double distanceTo =
        haversineDistanceFrom(latitude: latitude, longitude: longitude);
    return -(distanceTo * distanceFactor) +
        log(averageRating) * ratingFactor +
        (hasPatio ? 1 : 0) * (isSunny ? 1 : 0) * patioFactor +
        max(reviewCount.toDouble() * reviewCountFactor, 2);
  }

  /// squares number
  /// Parameters:
  ///  - num: any number
  /// Returns: num * num
  num _squared(num x) {
    return x * x;
  }
}
