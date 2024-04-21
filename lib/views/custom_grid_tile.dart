import 'package:auto_size_text/auto_size_text.dart';
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
    var color = const Color.fromARGB(255, 198, 219, 207);
    double elevation = 10;
    if(_isSunny && !_venue.hasPatio){
      color = const Color.fromARGB(255, 153, 170, 160);
      elevation = 0;
    }
    return Card(
        color: color,
        elevation: elevation,
        surfaceTintColor: const Color.fromARGB(255, 255, 255, 255),
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              /*FittedBox(
                child:*/ AutoSizeText(
                  _venue.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w400
                  )
                ),
              //),
              Text(
                _venue.description ?? '',
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300
                  )
              ),

              const Spacer(),
              FittedBox(
                child: Text(
                  '${Haversine.haversine(_latitude, _longitude, _venue.latitude, _venue.longitude).toStringAsFixed(2)} miles away',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w200
                  )
                ),
              )
            ]
          ),
        )
    );
  }

  void buttonAction(){
    print('${_venue.name} tapped!');
  }
}