import 'package:dijkstra_app/calculate_path_button.dart';
import 'package:dijkstra_app/fetch_data.dart';
import 'package:flutter/material.dart';

class CityListScreen extends StatefulWidget {
  @override
  _CityListScreenState createState() => _CityListScreenState();
}

class _CityListScreenState extends State<CityListScreen> {
  List<Map<String, dynamic>>? cities = [];
  Set<String> shortestPathSet = {};

  @override
  void initState() {
    super.initState();
    _loadCities();
  }

  Future<void> _loadCities() async {
    final loadedCities = await fetchAllCities();
    setState(() {
      cities = loadedCities;
    });
  }

  Future<void> _calculatePath(String startCity, String endCity) async {
    try {
      final path = await calculateShortestPath(startCity, endCity);
      print('Shortest Path: $path'); // Add this line

      setState(() {
        shortestPathSet =
            Set.from(path); // Update the set of city names in shortest path
      });

      // ---- new
    } catch (e) {
      print('Error: $e');
      // Handle error appropriately
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cities != null
          ? Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  CalculatePathButton(
                    calculateFunction: _calculatePath,
                  ),
                ],
              ),
            )
          : const CircularProgressIndicator(),
    );
  }
}
