import 'package:flutter/material.dart';

class WasteDetailScreen extends StatelessWidget {
  static const route = '/waste_detail';
  final String title = 'Waste Detail';
  const WasteDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wasteagram'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Text('$title Screen', style: Theme.of(context).textTheme.headline4),
        ]),
      ),
    );
  }
}
