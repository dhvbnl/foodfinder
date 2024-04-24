import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:food_finder/models/venue.dart';
import 'package:food_finder/providers/position_provider.dart';

/// creates an view for more details of power ranking calculation
/// Parameters:
///  - positionProvider: PositionProvider with current location data
///  - venue: venue to get data from 
///  - isSunny: if it's current sunny
class PowerRankingInfo extends StatelessWidget {
  final PositionProvider positionProvider;
  final Venue venue;
  final bool isSunny;

  const PowerRankingInfo(
      {required this.positionProvider,
      required this.venue,
      required this.isSunny,
      super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: AutoSizeText(
                      semanticsLabel: 'Power Ranking: ${venue.name}',
                      'Power Ranking: \n ${venue.name}',
                      minFontSize: 15,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inverseSurface,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w400,
                        fontSize: 35,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'The power ranking is calculated as such:',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Distance from location to venue'),
                          SizedBox(height: 3),
                          Text('Log of Average Rating'),
                          SizedBox(height: 3),
                          Text('If venue has a patio and it\'s sunny'),
                          SizedBox(height: 3),
                          Text('Review Count'),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '-${venue.haversineDistanceFrom(
                                  latitude: positionProvider.latitude,
                                  longitude: positionProvider.longitude,
                                ).toStringAsFixed(2)} * 4 +',
                          ),
                          const SizedBox(height: 3),
                          Text('log(${venue.averageRating}) * 2.5 +'),
                          const SizedBox(height: 3),
                          Text(
                              '${venue.hasPatio ? '1' : '0'} * ${isSunny ? '1' : '0'} * 2 +'),
                          const SizedBox(height: 3),
                          Text('max(${venue.reviewCount} * 0.003, 2) ='),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Final Power Ranking: ${venue.powerRanking(
                          latitude: positionProvider.latitude,
                          longitude: positionProvider.longitude,
                        ).toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
