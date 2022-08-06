import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/photo_storage_service.dart';
import '../widgets/camera_fab.dart';
import '../screens/_screens.dart';
import '../models/food_waste_post_list.dart';

class WasteListScreen extends StatefulWidget {
  static const route = '/';
  final String title = 'Wasteagram';
  final String collection = 'posts';
  const WasteListScreen({Key? key}) : super(key: key);

  @override
  State<WasteListScreen> createState() => WasteListScreenState();
}

class WasteListScreenState extends State<WasteListScreen> {
  final PhotoStorageService photoService = PhotoStorageService.getInstance();

  @override
  Widget build(BuildContext context) {
    return displayContent(context);
  }

  //--------------------------------------
  // Stream Builder Display - Updates as data changes
  //--------------------------------------
  Widget displayContent(BuildContext context) {
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection(widget.collection).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          //--------------------------------------
          // Convert snapshot to FoodWastePost List
          //--------------------------------------
          FoodWastePostList data = FoodWastePostList.fromSnapshot(snapshot);
          data.sort();

          //--------------------------------------
          // EXTRA CREDIT - Get sum total of wasted food 
          //--------------------------------------
          int sum = data.totalWaste;

          //--------------------------------------
          // Display List of Posts
          //--------------------------------------
          return Scaffold(
            appBar: AppBar(
              title: Text('${widget.title} - $sum'),
            ),
            body: Column(
              children: [
                Expanded(
                  // child: Text('okay'),
                  child: ListView.builder(
                    // itemCount: snapshot.data?.docs.length,
                    itemCount: data.posts.length,
                    itemBuilder: (context, index) {
                      // return dismissibleTile(context, index, snapshot);
                      // return dismissibleTile(context, index, data);
                      return dismissibleTile(context, data.posts[index]);
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton: const CameraFab(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        } else {
          //--------------------------------------
          // Display Circular Progress Indicator and button to select photo for upload
          //--------------------------------------
          return Scaffold(
            appBar: AppBar(
              title: Text('${widget.title} - 0'),
            ),
            body: const Center(child: CircularProgressIndicator()),
            floatingActionButton: const CameraFab(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        }
      },
    );
  }

  //--------------------------------------
  // Builds a Waste Tile that can be Deleted
  //--------------------------------------
  // Widget dismissibleTile(BuildContext context, index, data) {
  Widget dismissibleTile(BuildContext context, post) {

    return Semantics(
      label: 'Dismissable Tile',
      button: false,
      enabled: true,
      onTapHint: 'Slide left or right to delete post',
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) async {
          // 1. Delete image url
          photoService.deleteImageUsingRefUrl(post.imageUrl);
    
          // 2. Call Database and Delete Entry
          FirebaseFirestore.instance
              .collection(widget.collection)
              .doc(post.id)
              .delete();
    
          // 3. Update state of Waste Entries
          setState(() {});
        },
        // Background decoration
        background: Container(
            color: Colors.red,
            alignment: AlignmentDirectional.centerEnd,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            )),
        // child: entryTile(context, index, post),
        child: entryTile(context, post),
      ),
    );
  }

  //--------------------------------------
  // Builds Individual TILE for Journal List
  //--------------------------------------
  Widget entryTile(BuildContext context, post) {
    return Semantics(
      label: 'Post Tile',
      button: false,
      enabled: true,
      onTapHint: 'Tap to see post details',
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return WasteDetailScreen(post: post);
          }));
        },
        child: ListTile(
          title: Text(post.getFormattedDate,
              style:
                  Theme.of(context).textTheme.headline6), // Firebase doucment ID
          trailing: Text(post.quantity.toString(),
              style: Theme.of(context).textTheme.headline4),
        ),
      ),
    );
  }
}
