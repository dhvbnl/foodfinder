import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:food_finder/helpers/haversine.dart';
import 'package:food_finder/models/venue.dart';
import 'package:food_finder/providers/position_provider.dart';

/// Creates a tile based on venue and location information
/// Parameters:
///  - venue: venue of restaurant
///  - isSunny: if current weather is sunny
///  - positionProvider: current Provider for position data
class CustomGridTile extends StatelessWidget {
  final Venue venue;
  final bool isSunny;
  final PositionProvider positionProvider;

  const CustomGridTile({
    required this.venue,
    required this.isSunny,
    required this.positionProvider,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var color = const Color.fromARGB(255, 198, 219, 207);
    double elevation = 10;
    //changes color and elevation based on if its sunny and
    //the venue doesn't have a patio
    if (isSunny && !venue.hasPatio) {
      color = const Color.fromARGB(255, 153, 170, 160);
      elevation = 0;
    }
    return Card(
      color: color,
      elevation: elevation,
      surfaceTintColor: Colors.white,
      margin: const EdgeInsets.all(8.0),
      //sets up child for clickability
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.background,
        onTap: () {
          debugPrint('Card tapped.');
        },
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              venueName(context),
              reviewInformation(context),
              const Spacer(),
              distanceAway(),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a widget formatting venue Name
  /// Parameters:
  ///  - context: context of widget build
  /// Returns: AutoSizeText widget with venueName
  Widget venueName(BuildContext context) {
    return AutoSizeText(
      venue.name,
      textAlign: TextAlign.center,
      maxLines: 2,
      minFontSize: 23,
      style: TextStyle(
        fontWeight: FontWeight.w300,
        color: Theme.of(context).colorScheme.inverseSurface,
      ),
    );
  }

  /// Builds a widget containg review data
  /// Parameters:
  ///  - context: context of widget build
  /// Returns: Stack widget with average review, stars, and review count
  Widget reviewInformation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: AutoSizeText(
              minFontSize: 20,
              ' ${venue.averageRating}',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          Align(alignment: Alignment.center, child: reviewStars(context)),
          Align(
            alignment: Alignment.centerRight,
            child: AutoSizeText(
              minFontSize: 2,
              maxFontSize: 12,
              '(${venue.reviewCount}) ',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a widget containg review stars
  /// Parameters:
  ///  - context: context of widget build
  /// Returns: Row widget with stars matching rating
  Row reviewStars(BuildContext context) {
    List<Icon> stars = [];
    const size = 15.0;
    var color = Theme.of(context).colorScheme.secondary;
    //adds full stars
    for (int i = 0; i < venue.averageRating.floor(); i++) {
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
    if (venue.averageRating % 1 != 0) {
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

  /// Builds a widget containg distance to venue
  /// Returns: FittedBox with formatted distance to venue
  Widget distanceAway() {
    if (!positionProvider.locationFound) {
      return const Text('');
    }
    return FittedBox(
      child: Text(
        '${Haversine.haversine(
          positionProvider.latitude,
          positionProvider.longitude,
          venue.latitude,
          venue.longitude,
        ).toStringAsFixed(2)} miles away',
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
      ),
    );
  }

  void buttonAction() {
    print('${venue.name} tapped!');
  }
}
