import 'package:flutter/material.dart';
import 'package:food_finder/models/venue.dart';

class CustomGridTile extends StatelessWidget {
  final Venue _venue; 
  final bool _isSunny;

  const CustomGridTile(this._venue, this._isSunny, {super.key});

  @override
  Widget build(BuildContext context) {
    var backgroundColor = const Color.fromARGB(255, 200, 200, 200);
    //add code to change based on sunny or not
    return Card(
      color: backgroundColor,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              _venue.name,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400
              )
            ),
            const Spacer(),
            Text(
              '${_venue.distanceFrom(latitude: 1, longitude: 1)} miles away',
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w200
              )
            )
          ]
        ),
      )
    );
  }
}