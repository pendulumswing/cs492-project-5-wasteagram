import '../models/food_waste_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

class FoodWastePostService {
  // Image
  final String collection = 'posts';

  LocationData? locationData;
  var locationService = Location();

  //------------------
  // Singleton pattern
  //------------------
  static late FoodWastePostService _instance;

  FoodWastePostService._() {
    reset();
  }

  factory FoodWastePostService.getInstance() {
    return _instance;
  }

  static Future initialize() async {
    _instance = FoodWastePostService._();
  }

  void reset() {}

  //--------------------------------------
  // Add Meta Data (Location and Date)
  //--------------------------------------
  Future addMetaData(FoodWastePost post) async {
    // Location
    LocationData loc = await retreiveLocation();
    post.latitude = loc.latitude as double;
    post.longitude = loc.longitude as double;

    // Date
    post.date = DateTime.now();
  }

  //--------------------------------------
  // Upload Data to Firebase
  //--------------------------------------
  Future uploadData(FoodWastePost post) async {
    await addMetaData(post);

    FirebaseFirestore.instance.collection(collection).add({
      'date': post.date.toString(),
      'imageUrl': post.imageUrl,
      'quantity': post.quantity,
      'latitude': post.latitude,
      'longitude': post.longitude,
    });
  }

  
  //--------------------------------------
  // Retreive Location asynchronously.
  //--------------------------------------
  // Fetch local data variable before setting state synchronously.
  Future retreiveLocation() async {
    // Check if Location Permissions are set, then handle
    try {
      var serviceEnabled = await locationService.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await locationService.requestService();
        if (!serviceEnabled) {
          // print('Failed to enable service. Returning.');
          return;
        }
      }

      var permissionGranted = await locationService.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await locationService.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          // print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }

    // Fetch Location Data
    locationData = await locationService.getLocation();
    return locationData;
    // setState(() {});
  }
}
