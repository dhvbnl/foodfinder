import 'package:flutter/material.dart';
import 'package:food_finder/models/venue.dart';

class ExpandedTile extends StatelessWidget {
  final Venue venue;
  final OverlayEntry overlay;

  const ExpandedTile({required this.venue, required this.overlay, super.key});

  @override
  Widget build(BuildContext context) {
    var width;
    var height;
    if (MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height) {
      width = MediaQuery.of(context).size.height;
      height = width;
    } else {
      width = MediaQuery.of(context).size.width;
      height = width;
    }
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: width,
        height: MediaQuery.of(context).size.height -
            kToolbarHeight -
            MediaQuery.of(context).viewPadding.top -
            kBottomNavigationBarHeight,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => (overlay.remove()),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(venue.name),
                    ),
                  ],
                ),
                //const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
