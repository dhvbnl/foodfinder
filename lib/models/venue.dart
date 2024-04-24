import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
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
  /// 
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
  /// 
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
  ///  - patioFactor: increases score by 'patioFactor' is it's sunny and venue has a patio
  ///  - reviewCountFactor: increases score by 'reviewCountFactor' for every review
  ///  - isSunny: enbales patioFactor mattering
  /// 
  /// Returns: overall power ranking based on factors
  double powerRanking({
    required double latitude,
    required double longitude,
    double ratingFactor = 2.5,
    double distanceFactor = 4,
    double patioFactor = 2,
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
  /// 
  /// Returns: num * num
  num _squared(num x) {
    return x * x;
  }

  /// Builds a widget containg review data
  /// Parameters:
  ///  - context: context of widget build
  /// 
  /// Returns: Stack widget with average review, stars, and review count
  Widget reviewInformationCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: AutoSizeText(
              semanticsLabel: 'Rating: $averageRating stars',
              minFontSize: 20,
              ' $averageRating',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          Align(alignment: Alignment.center, child: reviewStars(context)),
          Align(
            alignment: Alignment.centerRight,
            child: AutoSizeText(
              semanticsLabel: '$reviewCount reviews',
              minFontSize: 2,
              maxFontSize: 12,
              '($reviewCount) ',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a widget containg review data
  /// Parameters:
  ///  - context: context of widget build
  /// 
  /// Returns: Stack widget with average review, stars, and review count
  Widget reviewInformationExpanded(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Row(
        children: [
          AutoSizeText(
            semanticsLabel: 'Rating: $averageRating',
            minFontSize: 20,
            '$averageRating',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          const SizedBox(
            width: 10,
          ),
          reviewStars(context),
          const SizedBox(
            width: 10,
          ),
          AutoSizeText(
            semanticsLabel: '$reviewCount reviews',
            minFontSize: 2,
            '($reviewCount) ',
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary, fontSize: 13),
          ),
        ],
      ),
    );
  }

  /// Builds a widget containg review stars
  /// Parameters:
  ///  - context: context of widget build
  /// 
  /// Returns: Row widget with stars matching rating
  Row reviewStars(BuildContext context) {
    List<Icon> stars = [];
    const size = 15.0;
    var color = Theme.of(context).colorScheme.secondary;
    //adds full stars
    for (int i = 0; i < averageRating.floor(); i++) {
      stars.add(
        Icon(
          Icons.star,
          fill: 1.0,
          size: size,
          color: color,
        ),
      );
    }
    //adds half star if rating isn't even
    if (averageRating % 1 != 0) {
      stars.add(
        Icon(
          Icons.star_half,
          size: size,
          color: color,
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: stars,
    );
  }
}
