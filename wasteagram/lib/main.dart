//--------------------------------------
// Main - Entry point to application
//--------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wasteagram/services/food_waste_post_service.dart';
import 'services/photo_storage_service.dart';
import 'app.dart';

void main() async {
  // Bind Widgets to setup framework...
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase instance
  await Firebase.initializeApp();
  await PhotoStorageService.initialize();
  await FoodWastePostService.initialize();

  // Allow responsiveness for these orientations...
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp
  ]);

  // Run the app...
  runApp(const App(title: 'Wastegram'));
}
