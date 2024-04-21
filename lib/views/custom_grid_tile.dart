import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:food_finder/helpers/haversine.dart';
import 'package:food_finder/models/venue.dart';

class CustomGridTile extends StatelessWidget {
  final Venue _venue;
  final bool _isSunny;
  final double _latitude;
  final double _longitude;

  const CustomGridTile(
      this._venue, this._isSunny, this._latitude, this._longitude,
      {super.key});

  @override
  Widget build(BuildContext context) {
    var color = const Color.fromARGB(255, 198, 219, 207);
    double elevation = 10;
    if (_isSunny && !_venue.hasPatio) {
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
          child: Column(children: [
            AutoSizeText(
                _venue.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                minFontSize: 23,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.inverseSurface
                )
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Stack(
                alignment: Alignment.center,
                children:[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      minFontSize: 20,
                      ' ${_venue.averageRating} ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary
                      )
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: reviewStars(_venue.averageRating, context)
                  ),
              ]),
            ),
            const Spacer(),
            FittedBox(
              child: Text(
                  '${Haversine.haversine(_latitude, _longitude, _venue.latitude, _venue.longitude).toStringAsFixed(2)} miles away',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w200)),
            )
          ]),
        ));
  }

  Widget reviewStars(double averageRating, BuildContext context){
    List<Icon> stars = [];
    const size = 15.0;
    var color = Theme.of(context).colorScheme.secondary;
    for(int i = 0; i < averageRating.floor(); i++){
      stars.add(
        Icon(
          Icons.star,
          fill: 1.0,
          size: size,
          color: color
        )
      );
    }
    if(averageRating % 1 != 0){
      stars.add(
        Icon(
          Icons.star_half,
          size: size,
          color: color
        )
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: stars);
  }

  void buttonAction() {
    print('${_venue.name} tapped!');
  }
}
