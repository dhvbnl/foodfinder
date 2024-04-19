import 'package:flutter/material.dart';
import 'package:food_finder/views/custom_grid_tile.dart';

class CustomGridView extends StatelessWidget {
  final List<CustomGridTile> _tiles;
  const CustomGridView(this._tiles, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(8),
      crossAxisCount: 2,
      children: _tiles,
    );
  }
}