//--------------------------------------
// MODEL - A List of Food Waste Posts
//--------------------------------------
import 'food_waste_post.dart';

class FoodWastePostList {
  List<FoodWastePost> posts = [];

  FoodWastePostList();

  //------------------
  // Constructor - Build List of Posts from Snapshot
  //------------------
  FoodWastePostList.fromSnapshot(snapshot) {
    List<dynamic> sdata = snapshot.data!.docs.toList();
    sdata.asMap().forEach((index, item) {
      FoodWastePost post = FoodWastePost.fromList(item);
      post.id = sdata[index].id;
      posts.add(post);
    });
  }

  //------------------
  // Bool - Check if posts list is empty
  //------------------
  bool isEmpty() => posts.isEmpty;


  //------------------
  // Sort - Most recent post first
  //------------------
  void sort() {
    posts.sort(
      (b, a) {
        return ((a.date as DateTime).compareTo(b.date as DateTime));
      },
    );
  }


  //------------------
  // Get - Sum total of all food waste in list of posts
  //------------------
  int get totalWaste {
    int sum = 0;
    posts.forEach((post) {
      sum += post.quantity;
    });
    return sum;
  }
}
