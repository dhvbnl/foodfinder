import 'package:food_finder/helpers/haversine.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:math';

part 'venue.g.dart';

// See documentation here https://docs.flutter.dev/data-and-backend/serialization/json#creating-model-classes-the-json_serializable-way
// After changing this class, it is essential to run `dart run build_runner build --delete-conflicting-outputs` from the root of the project.

var ratingFactor = 3;
var distanceFactor = 2.5;
var patioFactor = 2.5;
var reviewCountFactor = 0.0001;

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

  factory Venue.fromJson(Map<String, dynamic> json) => _$VenueFromJson(json);
  Map<String, dynamic> toJson() => _$VenueToJson(this);

  double distanceFrom({
    required double latitude,
    required double longitude,
  }) {
    return sqrt(_squared(this.latitude - latitude) +
        _squared(this.longitude - longitude));
  }

  double haversineDistanceFrom({
    required double latitude,
    required double longitude,
  }) {
    return Haversine.haversine(
        this.latitude, this.longitude, latitude, longitude);
  }

  double distanceInMeters({
    required double latitude,
    required double longitude,
  }) {
    return 111139 * distanceFrom(latitude: latitude, longitude: longitude);
  }

  double powerRanking({
    required double latitude,
    required double longitude,
    bool isSunny = false,
  }) {
    double distanceTo =
        haversineDistanceFrom(latitude: latitude, longitude: longitude);
    return -(distanceTo * distanceFactor) +
        averageRating * ratingFactor +
        (hasPatio ? 1 : 0) * (isSunny ? 1 : 0) * patioFactor +
        reviewCount.toDouble() * reviewCountFactor;
  }

  num _squared(num x) {
    return x * x;
  }
}
