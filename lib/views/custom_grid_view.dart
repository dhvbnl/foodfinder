import 'package:flutter/material.dart';
import 'package:food_finder/views/custom_grid_tile.dart';

  /// Creates a 2D expandable grid with given tiles
  /// Parameters:
  ///  - tiles: tiles of type CustomGridTile
class CustomGridView extends StatelessWidget {
  final List<CustomGridTile> tiles;
  const CustomGridView({required this.tiles, super.key});

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = 1;
    var windowSize = MediaQuery.of(context).size.width;
    //changes horizontal tiles based on the window size;
    if(windowSize <= 375){
      crossAxisCount = 1;
    } else if(windowSize <= 600){
      crossAxisCount = 2;
    } else if(windowSize <= 800){
      crossAxisCount = 3;
    } else if(windowSize <= 1100){
      crossAxisCount = 4;
    } else {
      crossAxisCount = 5;
    }
    return GridView.count(
      padding: const EdgeInsets.all(8),
      crossAxisCount: crossAxisCount,
      children: tiles,
    );
  }
}