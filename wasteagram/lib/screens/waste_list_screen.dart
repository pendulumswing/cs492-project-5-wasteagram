import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/camera_fab.dart';
import '../screens/_screens.dart';

class WasteListScreen extends StatefulWidget {
  static const route = '/';
  final String title = 'Waste List';
  final String collection = 'posts-test';
  const WasteListScreen({Key? key}) : super(key: key);

  @override
  State<WasteListScreen> createState() => WasteListScreenState();
}

class WasteListScreenState extends State<WasteListScreen> {
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
      stream: FirebaseFirestore.instance.collection(widget.collection).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          //--------------------------------------
          // Display List of Posts
          //--------------------------------------
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
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
    var post = snapshot.data!.docs[index];

    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) async {
        //------------------
        // DELETE POST
        //------------------
        // 1. Get image url to delete image first
        final String url = post['url'];

        // 2. Delete image url
        await FirebaseStorage.instance.refFromURL(url).delete();

        // 3. Call Database and Delete Entry
        FirebaseFirestore.instance
            .collection(widget.collection)
            .doc(post.id)
            .delete();

        // 4. Update state of Waste Entries
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
      child: entryTile(context, index, snapshot),
    );
  }

  //--------------------------------------
  // Builds Individual TILE for Journal List
  //--------------------------------------
  Widget entryTile(BuildContext context, index, snapshot) {
    var post = snapshot.data!.docs[index];

    return GestureDetector(
      // Handle behavior for different layouts...
      // If Vertical -> redirects to entry route, otherwise sets index value
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return const WasteDetailScreen();
          // return const WasteDetailScreen(entry: journal.entries[index]);
        }));
      },
      child: ListTile(
        // title: Text('Title $index'),
        title: Text('ID ${post.id}'), // Firebase doucment ID
        leading: ConstrainedBox(
          constraints: const BoxConstraints(
              minWidth: 40, maxWidth: 50, minHeight: 20, maxHeight: 30),
          child: post['url'] != null ? Image.network(post['url']) : Container(),
        ),
        trailing: Text(post['weight'].toString()),
      ),
    );
  }
}
