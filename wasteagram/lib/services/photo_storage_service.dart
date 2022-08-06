// Provides Image selectiong, database upload, and database deleting
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PhotoStorageService {
  // Image Data (Currently selected image)
  late String path;
  File? imageFile;
  late String refUrl;
  final picker = ImagePicker();

  //------------------
  // Singleton pattern
  //------------------
  static late PhotoStorageService _instance;

  PhotoStorageService._() {
    reset();
  }

  factory PhotoStorageService.getInstance() {
    return _instance;
  }

  static Future initialize() async {
    _instance = PhotoStorageService._();
  }

  //--------------------------------------
  // Pick an image from the gallery and return File from url
  //--------------------------------------
  Future getImagePath() async {
    // Get image file
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      path = pickedFile.path;
      return path;
    }
  }

  //--------------------------------------
  // Get File from path url (Simulator Gallery)
  //--------------------------------------
  Future getImageFileFromPath() async {
    if (path.isNotEmpty) {
      imageFile = File(path);
      return imageFile;
    }
  }


  //--------------------------------------
  // Pick an image from the gallery and return File
  //--------------------------------------
  Future selectImage() async {
    await getImagePath();
    await getImageFileFromPath();
    return imageFile;
  }

  //--------------------------------------
  // Upload image file to Firebase and get Reference URL
  //--------------------------------------
  Future getImageRefUrl() async {
    if (imageFile != null) {
      // Create a storage reference with a unique key for the file
      var fileName = '${DateTime.now().toString()}.jpg';
      Reference storageReference =
          FirebaseStorage.instance.ref().child(fileName);

      // Create an upload task by wrapping the file with the storage reference
      UploadTask uploadTask = storageReference.putFile(imageFile!);

      // --> upload task with file and storage reference
      await uploadTask;

      // <-- Get back the url where the file is stored
      refUrl = await storageReference.getDownloadURL();

      return refUrl;
    }
  }

  //--------------------------------------
  // Delete RefUrl image from storage after 10 seconds
  //--------------------------------------
  void deleteImageFromStorage() async {
    await Future.delayed(const Duration(seconds: 10));
    if (refUrl.isNotEmpty) {
      await FirebaseStorage.instance.refFromURL(refUrl).delete();
    }
  }

  //--------------------------------------
  // Delete given RefUrl image from storage
  //--------------------------------------
  void deleteImageUsingRefUrl(String url) async {
    if (url.isNotEmpty) {
      await FirebaseStorage.instance.refFromURL(url).delete();
    }
  }


  //--------------------------------------
  // Reset currently selected image data
  //--------------------------------------
  void reset() {
    path = '';
    imageFile = null;
    refUrl = '';
  }
}
