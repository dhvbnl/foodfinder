import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_finder/helpers/haversine.dart';
import 'package:food_finder/models/venue.dart';
import 'package:food_finder/providers/position_provider.dart';
import 'package:food_finder/views/expanded_tile.dart';

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
          buttonAction(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              venueName(context),
              venue.reviewInformationCard(context),
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
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w200,
        ),
      ),
    );
  }

  /// Pushes a ExpandedTile widget onto the NavigatorStack of current venue
  /// Parameters:
  ///  - context: context of widget build
  void buttonAction(
    BuildContext context,
  ) {
    if (Platform.isIOS || Platform.isMacOS) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => ExpandedTile(venue: venue, positionProvider: positionProvider, isSunny: isSunny,),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExpandedTile(venue: venue, positionProvider: positionProvider, isSunny: isSunny,),
        ),
      );
    }
  }
}
