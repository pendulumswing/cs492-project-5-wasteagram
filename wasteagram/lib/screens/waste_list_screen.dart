import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasteagram/models/food_waste_post.dart';
import 'package:wasteagram/services/photo_storage_service.dart';
import '../widgets/camera_fab.dart';
import '../screens/_screens.dart';

class WasteListScreen extends StatefulWidget {
  static const route = '/';
  final String title = 'Waste List';
  final String collection = 'posts';
  const WasteListScreen({Key? key}) : super(key: key);

  @override
  State<WasteListScreen> createState() => WasteListScreenState();
}

class WasteListScreenState extends State<WasteListScreen> {
  final PhotoStorageService photoService = PhotoStorageService.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: displayContent(context),
      floatingActionButton: const CameraFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget displayContent(BuildContext context) {
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection(widget.collection).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          //--------------------------------------
          // Display List of Posts
          //--------------------------------------
          return Column(
            children: [
              Expanded(
                // child: Text('okay'),
                child: ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return dismissibleTile(context, index, snapshot);
                  },
                ),
              ),
            ],
          );
        } else {
          //--------------------------------------
          // Display Circular Progress Indicator and button to select photo for upload
          //--------------------------------------
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  //--------------------------------------
  // Builds a Waste Tile that can be Deleted
  //--------------------------------------
  Widget dismissibleTile(BuildContext context, index, snapshot) {
    FoodWastePost post = FoodWastePost.fromSnapshot(snapshot.data!.docs[index]);

    return Dismissible(
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
      child: entryTile(context, index, post),
    );
  }

  //--------------------------------------
  // Builds Individual TILE for Journal List
  //--------------------------------------
  Widget entryTile(BuildContext context, index, post) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return WasteDetailScreen(post: post);
        }));
      },
      child: ListTile(
        title: Text(post.getFormattedDate, style: Theme.of(context).textTheme.headline6), // Firebase doucment ID
        trailing: Text(post.quantity.toString(), style: Theme.of(context).textTheme.headline4),
      ),
    );
  }
}
