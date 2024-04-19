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
    var backgroundColor = const Color.fromARGB(255, 100, 100, 100);
    if(_isSunny){
      backgroundColor = const Color.fromARGB(255, 200, 200, 200);
    }
    
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
            // TODO(data): fixed nearest to data to be arricuate to miles 
            Text(
              //'${_venue.distanceFrom(latitude: _latitude, longitude: _longitude).toStringAsFixed(3)} miles away',
              '${Haversine.haversine(_latitude, _longitude, _venue.latitude, _venue.longitude).toStringAsFixed(2)} miles away',
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