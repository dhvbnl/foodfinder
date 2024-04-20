import 'package:flutter/material.dart';
import 'package:food_finder/helpers/haversine.dart';
import 'package:food_finder/models/venue.dart';

class CustomGridTile extends StatelessWidget {
  final Venue _venue; 
  final bool _isSunny;
  final double _latitude;
  final double _longitude;

  const CustomGridTile(this._venue, this._isSunny, this._latitude, this._longitude, {super.key});

  @override
  Widget build(BuildContext context) {
    //add code to change based on sunny or not
    var color = const Color.fromARGB(255, 198, 219, 207);
    double elevation = 10;
    if(_isSunny && !_venue.hasPatio){
      color = Color.fromARGB(255, 178, 198, 186);
      elevation = 0;
    }
    //add code to scale text
    return Card(
      color: color,
      elevation: elevation,
      surfaceTintColor: const Color.fromARGB(255, 255, 255, 255),
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              _venue.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w400
              )
            ),
            const Spacer(),
            Text(
              '${Haversine.haversine(_latitude, _longitude, _venue.latitude, _venue.longitude).toStringAsFixed(2)} miles away',
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w200
              )
            )
          ]
        ),
      )
    );
  }
}