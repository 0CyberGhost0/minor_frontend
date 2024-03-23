import 'package:dijkstra_app/city_graph.dart';
import 'package:dijkstra_app/fetch_data.dart';
import 'package:dijkstra_app/test.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class CalculatePathButton extends StatefulWidget {
  final Future<void> Function(String, String) calculateFunction;

  CalculatePathButton({required this.calculateFunction});

  @override
  _CalculatePathButtonState createState() => _CalculatePathButtonState();
}

class _CalculatePathButtonState extends State<CalculatePathButton> {
  TextEditingController startCityController = TextEditingController();
  TextEditingController endCityController = TextEditingController();
  List<String> shortestPath = [];
  List<Map<String, dynamic>>? cities = [];
  Set<String> shortestPathSet = {};
  final graph = Graph();
  final Map<String, Node> nodeMap = {};
  // late GraphView graphView;
  // List<City> citiess = [];

  //------------------------------------------------

  @override
  void initState() {
    super.initState();
    _loadCities();
  }

  //------------------------------------------------

  Future<void> _loadCities() async {
    final loadedCities = await fetchAllCities();
    //print(loadedCities);
    setState(() {
      cities = loadedCities;
    });
    for (final city in cities!) {
      final node = Node.Id(city['name']);
      nodeMap[city['_id']] = node;
      graph.addNode(node);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(shortestPath);
    return SizedBox(
      height: 800,
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GraphScreen(graph: graph),
                  ),
                );
              },
              child: const Text('navigate')),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: startCityController,
                  decoration: const InputDecoration(labelText: 'Start City'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: endCityController,
                  decoration: const InputDecoration(labelText: 'End City'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              try {
                final path = await calculateShortestPath(
                  startCityController.text,
                  endCityController.text,
                );
                setState(() {
                  shortestPath = path;
                });
              } catch (e) {
                print('Error: $e');
                // Handle error appropriately
              }
            },
            child: const Text('Calculate Shortest Path'),
          ),
          shortestPath.isNotEmpty
              ? Text('Shortest Path: ${shortestPath.join(" -> ")}')
              : const SizedBox.shrink(),
          Flexible(
            child: CityGraph(
                cities!.map((city) => city['name'] as String).toList(),
                shortestPath),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    startCityController.dispose();
    endCityController.dispose();
    super.dispose();
  }
}
