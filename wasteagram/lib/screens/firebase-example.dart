// 9.3.2 - Firebase Upload Image File (binary) to cloud storage and retrieve Url to display
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';

//--------------------------------------
// Main
//--------------------------------------
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App(title: 'Firebase File Storage'));
}

//--------------------------------------
// App
//--------------------------------------
class App extends StatelessWidget {
  final String title;

  const App({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      showSemanticsDebugger: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: const CameraScreen(),
      ),
    );
  }
}

//--------------------------------------
// Camera Screen
//--------------------------------------
class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  File? image;
  final picker = ImagePicker();

  //--------------------------------------  
  // Pick an image from the gallery, upload it to Firebase Storage and return 
  // the URL of the image in Firebase Storage.
  //--------------------------------------  
  Future getImage() async {
    // Get image url
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);

      // Create a storage reference with a unique key for the file
      var fileName = '${DateTime.now().toString()}.jpg';
      Reference storageReference =
          FirebaseStorage.instance.ref().child(fileName);

      // Create an upload task by wrapping the file with the storage reference
      UploadTask uploadTask = storageReference.putFile(image!);

      // --> upload task with file and storage reference
      await uploadTask;

      // <-- Get back the url where the file is stored
      final url = await storageReference.getDownloadURL();
      print(url);
      return url;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts-test').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData &&
              // snapshot.data!.docs != null &&
              snapshot.data!.docs.isNotEmpty) {
            //--------------------------------------
            // Display List of Posts
            //--------------------------------------
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var post = snapshot.data!.docs[index];
                      return ListTile(
                        title: Text('Title $index'),
                        leading: ConstrainedBox(
                          constraints: const BoxConstraints(
                              minWidth: 40,
                              maxWidth: 50,
                              minHeight: 20,
                              maxHeight: 30),
                          child: post['url'] != null
                              ? Image.network(post['url'])
                              : Container(),
                        ),
                        trailing: Text(post['weight'].toString()),
                      );
                    },
                  ),
                ),
                //------------------
                // Button
                //------------------
                ElevatedButton(
                  child: const Text('Select photo and upload data'),
                  onPressed: () {
                    uploadData();
                  },
                ),
              ],
            );
          } else {
            //--------------------------------------
            // Display Circular Progress Indicator and button to select photo for upload
            //--------------------------------------
            return Column(
              children: [
                const Center(child: CircularProgressIndicator()),
                ElevatedButton(
                  child: const Text('Select photo and upload data'),
                  onPressed: () {
                    uploadData();
                  },
                ),
              ],
            );
          }
        });
  }


  //--------------------------------------
  // Upload Data ()
  //--------------------------------------
  void uploadData() async {
    final url = await getImage();
    final weight = DateTime.now().millisecondsSinceEpoch % 1000;
    final title = 'Title $weight';
    FirebaseFirestore.instance
        .collection('posts-test')
        .add({'weight': weight, 'title': title, 'url': url});
  }
}
