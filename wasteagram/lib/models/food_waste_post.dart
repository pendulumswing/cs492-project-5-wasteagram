//--------------------------------------
// MODEL - Food Waste Post
//--------------------------------------
class FoodWastePost {
  DateTime? date = DateTime(2022);
  String? photoUrl = '';
  int? quantity = 0;
  double? latitude = 0;
  double? longitude = 0;

  FoodWastePost({
    this.date,
    this.photoUrl,
    this.quantity,
    this.latitude,
    this.longitude,
  });

  // void set date(DateTime value) {date = value;}

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
