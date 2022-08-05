import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:wasteagram/screens/_screens.dart';

class CameraFab extends StatefulWidget {
  const CameraFab({Key? key}) : super(key: key);

  @override
  State<CameraFab> createState() => _CameraFabState();
}

class _CameraFabState extends State<CameraFab> {
  // Image
  File? image;
  final picker = ImagePicker();
  // Location
  LocationData? locationData;
  var locationService = Location();

  //--------------------------------------
  // Pick an image from the gallery and return File from url
  //--------------------------------------
  Future getImageFile() async {
    // Get image file
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final File file = await getImageFile();
        if (!mounted) return; // Check if still mounted before setting state
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return NewWasteScreen(file: file);
        }));
      },
      backgroundColor: Colors.blueGrey,
      child: const Icon(Icons.camera_alt_rounded),
    );
  }
}
