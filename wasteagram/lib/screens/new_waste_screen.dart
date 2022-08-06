import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wasteagram/services/photo_storage_service.dart';
import '../widgets/wasted_food_form.dart';

class NewWasteScreen extends StatefulWidget {
  static const route = '/new_waste_screen';
  final String title = 'New Post';
  final File file;

  const NewWasteScreen({Key? key, required this.file}) : super(key: key);

  @override
  State<NewWasteScreen> createState() => _NewWasteScreenState();
}

class _NewWasteScreenState extends State<NewWasteScreen> {
  final photoService = PhotoStorageService.getInstance();
  late String url = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getImage();
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (url.isEmpty) {
      // Remove stranded photourl if post is not completed beforehand
      photoService.deleteImageFromStorage();
    }
  }

  //--------------------------------------
  // Upload file to Firebase Storage and return
  // the refURL of the image.
  // Asynchronous - update state when complete.
  //--------------------------------------
  void getImage() async {
    await photoService.getImageRefUrl();

    // Check if still mounted before setting state
    if (!mounted) return;

    // Update state to trigger page redirect
    setState(() {
      url = photoService.refUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      //------------------
      // Circular Progress
      //------------------
      return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ));
    } else {
      //------------------
      // New Entry Form
      //------------------
      return WastedFoodForm(url: url);
    }
  }
}
