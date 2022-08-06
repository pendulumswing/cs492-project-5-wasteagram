// 10.1.1 - Unit Test
import 'package:test/test.dart';
import 'package:wasteagram/models/food_waste_post.dart';

void main() {
  //--------------------------------------
  // TEST - getFormattedDate()
  //--------------------------------------
  test('Formatted date should display Day of the Week, Month, Day, Year', () {
    //------------------
    // 1. Setup
    //------------------
    const dateAsString = '2022-08-05 21:31:45.059692';
    final date = DateTime.parse(dateAsString);
    const expectedOutput = 'Friday, August 5, 2022';

    //------------------
    // 2. Exercise
    //------------------
    final post = FoodWastePost();
    post.date = date;

    //------------------
    // 3. Verify
    //------------------
    expect(post.getFormattedDate, expectedOutput);
  });

  //--------------------------------------
  // TEST - getFormattedDateShort()
  //--------------------------------------
  test('Formatted date should display date in format of "Fri, Aug 5, 2022', () {
    //------------------
    // 1. Setup
    //------------------
    const dateAsString = '2022-08-05 21:31:45.059692';
    final date = DateTime.parse(dateAsString);
    const expectedOutput = 'Fri, Aug 5, 2022';

    //------------------
    // 2. Exercise
    //------------------
    final post = FoodWastePost();
    post.date = date;

    //------------------
    // 3. Verify
    //------------------
    expect(post.getFormattedDateShort, expectedOutput);
  });

  //--------------------------------------
  // TEST - from Map
  //--------------------------------------
  test('Post created from Map should have appropriate property values', () {
    //------------------
    // 1. Setup
    //------------------
    const id = 'id';
    final date = DateTime.parse('2022-08-05 21:31:45.059692');
    const imageUrl = 'FAKE';
    const quantity = 1;
    const latitude = 1.0;
    const longitude = 2.0;

    //------------------
    // 2. Exercise
    //------------------
    final foodWastePost = FoodWastePost.fromMap({
      'id': id,
      'date': date,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'latitude': latitude,
      'longitude': longitude
    });

    //------------------
    // 3. Verify
    //------------------
    expect(foodWastePost.id, id);
    expect(foodWastePost.date, date);
    expect(foodWastePost.imageUrl, imageUrl);
    expect(foodWastePost.quantity, quantity);
    expect(foodWastePost.latitude, latitude);
    expect(foodWastePost.longitude, longitude);
  });

  //--------------------------------------
  // TEST - from Map
  //--------------------------------------
  test('Post created from JSON should have appropriate property values', () {
    //------------------
    // 1. Setup
    //------------------
    const id = 'id';
    final date = DateTime.parse('2022-08-05 21:31:45.059692');
    const imageUrl = 'FAKE';
    const quantity = 1;
    const latitude = 1.0;
    const longitude = 2.0;

    //------------------
    // 2. Exercise
    //------------------
    final foodWastePost = FoodWastePost.fromJSON({
      'id': id.toString(),
      'date': date.toString(),
      'imageUrl': imageUrl.toString(),
      'quantity': quantity.toString(),
      'latitude': latitude.toString(),
      'longitude': longitude.toString()
    });

    //------------------
    // 3. Verify
    //------------------
    expect(foodWastePost.id, id);
    expect(foodWastePost.date, date);
    expect(foodWastePost.imageUrl, imageUrl);
    expect(foodWastePost.quantity, quantity);
    expect(foodWastePost.latitude, latitude);
    expect(foodWastePost.longitude, longitude);
  });

  //--------------------------------------
  // TEST - from List
  //--------------------------------------
  test('Post created from MapNoId should have appropriate property values', () {
    //------------------
    // 1. Setup
    //------------------
    // const id = 'id';
    final date = DateTime.parse('2022-08-05 21:31:45.059692');
    const imageUrl = 'FAKE';
    const quantity = 1;
    const latitude = 1.0;
    const longitude = 2.0;

    //------------------
    // 2. Exercise
    //------------------
    final foodWastePost = FoodWastePost.fromMapNoId({
      // 'id': id,
      'date': date.toString(),
      'imageUrl': imageUrl,
      'quantity': quantity,
      'latitude': latitude,
      'longitude': longitude
    });

    //------------------
    // 3. Verify
    //------------------
    // expect(foodWastePost.id, id);
    expect(foodWastePost.date, date);
    expect(foodWastePost.imageUrl, imageUrl);
    expect(foodWastePost.quantity, quantity);
    expect(foodWastePost.latitude, latitude);
    expect(foodWastePost.longitude, longitude);
  });
}
