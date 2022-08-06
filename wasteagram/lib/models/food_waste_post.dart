//--------------------------------------
// MODEL - Food Waste Post
//--------------------------------------
import 'package:intl/intl.dart';
import 'dart:math';
import 'dart:convert';

class FoodWastePost {
  String id = '';
  DateTime? date = DateTime(2022);
  String imageUrl = '';
  int quantity = 0;
  double latitude = 0;
  double longitude = 0;

  FoodWastePost({
    this.id = '',
    this.date,
    this.imageUrl = '',
    this.quantity = 0,
    this.latitude = 0,
    this.longitude = 0,
  });

  // Example - "Friday, August 5, 2022"
  String get getFormattedDate {
    return DateFormat.yMMMMEEEEd().format(date ?? DateTime(2022));
  }

  // Example - "Fri, Aug 5, 2022"
  String get getFormattedDateShort {
    return DateFormat.yMMMEd().format(date ?? DateTime(2022));
  }

  //--------------------------------------
  // Create FoodWastePost object from Snapshot
  //--------------------------------------
  factory FoodWastePost.fromSnapshot(map) {
    return FoodWastePost(
      id: map.id,
      date: DateTime.parse(map['date']),
      imageUrl: map['imageUrl'],
      quantity: map['quantity'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  //--------------------------------------
  // Create FoodWastePost object from Snapshot
  //--------------------------------------
  factory FoodWastePost.fromList(map) {
    return FoodWastePost(
      // id: map['id'],
      date: DateTime.parse(map['date']),
      imageUrl: map['imageUrl'],
      quantity: map['quantity'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  //--------------------------------------
  // Create FoodWastePost object from JSON
  //--------------------------------------
  factory FoodWastePost.fromJSON(Map<String, dynamic> json) {
    return FoodWastePost(
      id: json['id'],
      date: json['date'],
      imageUrl: json['imageUrl'],
      quantity: int.parse(json['quantity']),
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
    );
  }

  //--------------------------------------
  // Create FoodWastePost object from Map
  //--------------------------------------
  factory FoodWastePost.fromMap(Map<dynamic, dynamic> map) {
    return FoodWastePost(
      id: map['id'],
      date: map['date'],
      imageUrl: map['imageUrl'],
      quantity: map['quantity'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}
