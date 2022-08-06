import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wasteagram/screens/_screens.dart';
import 'package:wasteagram/services/photo_storage_service.dart';

class CameraFab extends StatefulWidget {
  const CameraFab({Key? key}) : super(key: key);

  @override
  State<CameraFab> createState() => _CameraFabState();
}

class _CameraFabState extends State<CameraFab> {
  final PhotoStorageService photoService = PhotoStorageService.getInstance();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final File file = await photoService.selectImage();
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
