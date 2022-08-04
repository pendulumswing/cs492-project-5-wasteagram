// TODO:
import 'package:flutter/material.dart';

class WasteListScreen extends StatefulWidget {
  static const route = '/';
  final String title = 'Waste List';
  const WasteListScreen({Key? key}) : super(key: key);

  @override
  State<WasteListScreen> createState() => _WasteListScreenState();
}

class _WasteListScreenState extends State<WasteListScreen> {
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
