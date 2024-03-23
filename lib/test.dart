import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

Widget rectangleWidget(String a) {
  return InkWell(
    onTap: () {
      print('clicked');
    },
    child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(color: Colors.blue, spreadRadius: 1),
          ],
        ),
        child: Text('Node ${a}')),
  );
}

class GraphScreen extends StatefulWidget {
  final Graph graph;

  GraphScreen({required this.graph});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('City Graph'),
      ),
      body: Column(
        children: [
          Expanded(
            child: InteractiveViewer(
              constrained: false,
              boundaryMargin: EdgeInsets.all(100),
              minScale: 0.01,
              maxScale: 5.6,
              child: GraphView(
                graph: widget.graph,
                paint: Paint()
                  ..color = Colors.blue, // Customize node appearance
                algorithm: SugiyamaAlgorithm(SugiyamaConfiguration()),

                builder: (Node node) {
                  var a = node.key?.value as String;
                  return rectangleWidget(a);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
