import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:food_finder/helpers/url.dart';
import 'package:food_finder/models/venue.dart';
import 'package:food_finder/providers/position_provider.dart';
import 'package:food_finder/views/map_view.dart';
import 'package:latlong2/latlong.dart';
import 'package:maps_launcher/maps_launcher.dart';

/// creates an expanded tile view for more details on a venue
/// Parameters:
///  - venue: venue to get data from
class ExpandedTile extends StatelessWidget {
  final Venue venue;
  final PositionProvider positionProvider;
  final bool isSunny;

  const ExpandedTile(
      {required this.venue,
      required this.positionProvider,
      required this.isSunny,
      super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Column(
              children: [
                cardWithVenueData(context),
                const SizedBox(height: 5),
                cardWithMapData(context),
                const SizedBox(height: 5),
                formattedButtonRow(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a Card with restaurant data for Expanded Tile View
  /// Parameters:
  ///  - context: context of widget build
  ///  - text: text to display on button
  ///  - icon: icon to display on button
  ///  - urlLaunch: function to launch when button it tapped
  /// Returns: PlatformElevatedButton widget with data embedded
  Widget cardWithVenueData(
    BuildContext context,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            AutoSizeText(
              venue.name,
              minFontSize: 15,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inverseSurface,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w400,
                  fontSize: 35),
            ),
            const SizedBox(height: 5),
            venue.reviewInformationExpanded(context),
            const SizedBox(height: 5),
            if (venue.description != null)
              AutoSizeText(
                venue.description ?? '',
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }

  /// Builds a Card with map data of venue for Expanded Tile View
  /// Parameters:
  ///  - context: context of widget build
  /// Returns: Card widget with map embedded using flutter_map
  Widget cardWithMapData(BuildContext context) {
    return Card.outlined(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
          color: Color.fromARGB(255, 198, 219, 207),
          width: 2.0,
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.aspectRatio < 0.6 ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width / 4,
          child: FlutterMap(
            options: MapOptions(
                initialCenter: LatLng(
                  venue.latitude,
                  venue.longitude,
                ),
                initialZoom: 15,
                maxZoom: 19,
                minZoom: 13,
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.pinchZoom,
                ),
                onTap: (a, b) =>
                    MapsLauncher.launchQuery(venue.fulladdress).ignore()),
            children: [
              TileLayer(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/mapbox/light-v11/tiles/512/{z}/{x}/{y}@2x?access_token=$mapboxApiKey',
                userAgentPackageName: 'com.food_finder.app',
                tileProvider: CancellableNetworkTileProvider(),
              ),
              MarkerLayer(
                markers: [
                  Marker(
                      point: LatLng(venue.latitude, venue.longitude),
                      width: 20,
                      height: 20,
                      alignment: Alignment.topCenter,
                      child: const Icon(Icons.location_on))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a Row for Expanded Tile View with all buttons possible with data
  /// Parameters:
  ///  - context: context of widget build
  /// Returns: Row widget with buttons evenly placed
  Widget formattedButtonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (venue.website != null)
          formattedButton(
            context,
            'Website',
            Icons.language,
            () => Url.openUrl(venue.website ?? ''),
          ),
        if (venue.phone != null)
          formattedButton(
            context,
            'Call',
            Icons.call,
            () => Url.openUrl(
              'tel: ${venue.phone ?? ''}',
            ),
          ),
        if (venue.hasPatio)
          powerRankingToolTip(context, 'Patio', 'This venue has a patio!', Icons.deck, () => null),
        formattedButton(
          context,
          venue
              .powerRanking(
                latitude: positionProvider.latitude,
                longitude: positionProvider.longitude,
                isSunny: isSunny,
              )
              .toStringAsFixed(2),
          Icons.analytics,
          () => null,
        ),
      ],
    );
  }

  /// Builds a PlatformElevatedButton for Expanded Tile View
  /// Parameters:
  ///  - context: context of widget build
  ///  - text: text to display on button
  ///  - icon: icon to display on button
  ///  - urlLaunch: function to launch when button it tapped
  /// Returns: PlatformElevatedButton widget with data embedded
  Widget formattedButton(
    BuildContext context,
    String text,
    IconData icon,
    Function() function,
  ) {
    return PlatformElevatedButton(
      onPressed: function,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
      color: const Color.fromARGB(255, 198, 219, 207),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.inverseSurface,
          ),
          const SizedBox(
            width: 7,
          ),
          AutoSizeText(
            text,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget powerRankingToolTip(
    BuildContext context,
    String text,
    String message,
    IconData icon,
    Function() function,
  ) {
    return Tooltip(
      message: message,
      preferBelow: false,
      child: formattedButton(context, text, icon, function),
    );
  }
}
