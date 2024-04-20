import 'package:flutter/material.dart';
import 'package:food_finder/views/custom_grid_tile.dart';

class CustomGridView extends StatelessWidget {
  final List<CustomGridTile> _tiles;
  const CustomGridView(this._tiles, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO(axixcount): adjust to make more granular
    int crossAxisCount = 1;
    var windowSize = MediaQuery.of(context).size.width;
    if(windowSize <= 300){
      crossAxisCount = 1;
    } else if(windowSize <= 800){
      crossAxisCount = 2;
    } else if(windowSize <= 1200){
      crossAxisCount = 3;
    } else if(windowSize <= 1600){
      crossAxisCount = 4;
    }
    return GridView.count(
      padding: const EdgeInsets.all(8),
      crossAxisCount: crossAxisCount,
      children: _tiles,
    );
  }
}