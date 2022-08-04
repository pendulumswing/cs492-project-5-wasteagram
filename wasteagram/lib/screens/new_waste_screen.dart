// TODO:
import 'package:flutter/material.dart';

class NewWasteScreen extends StatefulWidget {
  static const route = '/new_waste_screen';
  final String title = 'New Waste';

  const NewWasteScreen({Key? key}) : super(key: key);

  @override
  State<NewWasteScreen> createState() => _NewWasteScreenState();
}

class _NewWasteScreenState extends State<NewWasteScreen> {
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
