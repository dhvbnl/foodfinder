import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:food_finder/helpers/haversine.dart';
import 'package:food_finder/models/venue.dart';
import 'package:food_finder/providers/position_provider.dart';

class CustomGridTile extends StatelessWidget {
  final Venue venue;
  final bool isSunny;
  final PositionProvider positionProvider;
  final bool locationFound;

  const CustomGridTile({
    required this.venue,
    required this.isSunny,
    required this.positionProvider,
    required this.locationFound,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var color = const Color.fromARGB(255, 198, 219, 207);
    double elevation = 10;
    if (isSunny && !venue.hasPatio) {
      color = const Color.fromARGB(255, 153, 170, 160);
      elevation = 0;
    }
    return Card(
      color: color,
      elevation: elevation,
      surfaceTintColor: const Color.fromARGB(255, 255, 255, 255),
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.background,
        onTap: () {
          debugPrint('Card tapped.');
        },
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              AutoSizeText(venue.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  minFontSize: 23,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context).colorScheme.inverseSurface)),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        minFontSize: 20,
                        ' ${venue.averageRating}',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: reviewStars(context)),
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
              ),
              const Spacer(),
              FittedBox(
                child: Text(
                  '${Haversine.haversine(positionProvider.latitude, positionProvider.longitude, venue.latitude, venue.longitude).toStringAsFixed(2)} miles away',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget reviewStars(BuildContext context) {
    List<Icon> stars = [];
    const size = 15.0;
    var color = Theme.of(context).colorScheme.secondary;
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

  Widget distanceAway() {
    if (!locationFound) {
      return const Text('');
    }
    return Text(
        '${Haversine.haversine(positionProvider.latitude, positionProvider.longitude, venue.latitude, venue.longitude).toStringAsFixed(2)} miles away',
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w200));
  }

  void buttonAction() {
    print('${venue.name} tapped!');
  }
}
