//--------------------------------------
// MODEL - Food Waste Post
//--------------------------------------
class FoodWastePost {
  final DateTime date;
  final String photoUrl;
  final int quantity;
  final double latitude;
  final double longitude;

  FoodWastePost({
    required this.date, 
    required this.photoUrl,
    required this.quantity,
    required this.latitude,
    required this.longitude,
  });


  factory FoodWastePost.fromJSON(Map<String, dynamic> json) {
    return FoodWastePost(
      date: DateTime.parse(json['date']),
      photoUrl: json['photoUrl'],
      quantity: int.parse(json['quantity']),
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
    );
  }

  factory FoodWastePost.fromMap(Map<String, dynamic> map) {
    return FoodWastePost(
      // date: DateTime.parse(map['date']),
      date: map['date'],
      photoUrl: map['photoUrl'],
      quantity: map['quantity'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}

