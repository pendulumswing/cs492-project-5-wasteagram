import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../widgets/wasted_food_form.dart';

class NewWasteScreen extends StatefulWidget {
  static const route = '/new_waste_screen';
  final String title = 'New Post';
  final File? file;

  NewWasteScreen({Key? key, this.file}) : super(key: key);

  @override
  State<NewWasteScreen> createState() => _NewWasteScreenState();
}

class _NewWasteScreenState extends State<NewWasteScreen> {
  late String url = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getImage());
  }

  @override
  Widget build(BuildContext context) {
    if(url.isEmpty) {
      //------------------
      // Circular Progress
      //------------------
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        )
      );
    } else {
      //------------------
      // New Entry Form
      //------------------
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: WastedFoodForm(url: url),
        resizeToAvoidBottomInset: false,
        // bottomNavigationBar: Container(child: Text('save')),
      );
    }

  }

  //--------------------------------------
  // Upload file to Firebase Storage and return
  // the URL of the image in Firebase Storage.
  // Asynchronous - update state when complete.
  //--------------------------------------
  void getImage() async {
    if (widget.file != null) {
      // Create a storage reference with a unique key for the file
      var fileName = '${DateTime.now().toString()}.jpg';
      Reference storageReference =
          FirebaseStorage.instance.ref().child(fileName);

      // Create an upload task by wrapping the file with the storage reference
      UploadTask uploadTask = storageReference.putFile(widget.file!);

      // --> upload task with file and storage reference
      await uploadTask;

      // <-- Get back the url where the file is stored
      final photoUrl = await storageReference.getDownloadURL();

      // Check if still mounted before setting state
      if (!mounted) return;  

      // Update state to trigger page redirect
      setState(() {
        url = photoUrl;
      });
    }
  }
}
