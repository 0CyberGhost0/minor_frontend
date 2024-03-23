import 'package:dijkstra_app/city_card.dart';
import 'package:flutter/material.dart';

class CityGraph extends StatelessWidget {
  final List<String> cityNames;
  final List<String> shortestPathSet;

  CityGraph(
    this.cityNames,
    this.shortestPathSet,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: cityNames.length,
        itemBuilder: (context, index) {
          final cityName = cityNames[index];
          final isInShortestPath = shortestPathSet.contains(cityName);
          return CityCard(cityNames[index], isInShortestPath);
        },
      ),
    );
  }
}
