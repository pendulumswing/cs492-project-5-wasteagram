// TODO:
import 'package:flutter/material.dart';

class WasteDetailScreen extends StatefulWidget {
  static const route = '/waste_detail';
  final String title = 'Waste Detail';
  const WasteDetailScreen({Key? key}) : super(key: key);

  @override
  State<WasteDetailScreen> createState() => _WasteDetailScreenState();
}

class _WasteDetailScreenState extends State<WasteDetailScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Text('${widget.title} Screen',
            style: Theme.of(context).textTheme.headline4),
      ),
    );
  }
}
