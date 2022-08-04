//--------------------------------------
// Main - Entry point to application
//--------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';

void main() async {
  // Bind Widgets to setup framework...
  WidgetsFlutterBinding.ensureInitialized();

  // Load SCHEMA from file
  // var schema = await getSchemaData('assets/schema_1.sql.txt');

  // Allow responsiveness for these orientations...
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp
  ]);

  // Setup database instance
  // await DatabaseManager.initialize(schema: schema);

  // Run the app...
  runApp(const App(title: 'Wastegram'));
}
