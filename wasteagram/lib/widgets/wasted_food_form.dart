//--------------------------------------
// Form - To Enter values for new Journal Entry
//--------------------------------------
import 'package:flutter/material.dart';
import 'package:wasteagram/services/food_waste_post_service.dart';
import 'package:wasteagram/services/photo_storage_service.dart';
import '../screens/_screens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import '../models/food_waste_post.dart';

class WastedFoodForm extends StatefulWidget {
  static final GlobalKey formKey = GlobalKey();
  final String? url;
  WastedFoodForm({Key? key, this.url}) : super(key: key);

  @override
  State<WastedFoodForm> createState() => _WastedFoodFormState();
}

class _WastedFoodFormState extends State<WastedFoodForm> {
  final formKey = GlobalKey<FormState>();
  bool uploadedDataSuccessful = false; // To track if post was submitted
  PhotoStorageService photoService = PhotoStorageService.getInstance();
  FoodWastePostService postService = FoodWastePostService.getInstance();
  final FoodWastePost newPost = FoodWastePost();

  @override
  void dispose() {
    super.dispose();
    if (widget.url != null && !uploadedDataSuccessful) {
      photoService.deleteImageFromStorage();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get handle on parent Widget of a certain type...
    final WasteListScreenState? wastedListScreen =
        context.findAncestorStateOfType<WasteListScreenState>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('New Post'),
        ),
        body: Container(
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 300,
                ),
                // child: Image.network(
                //   widget.url ?? '',
                // ),
                child: Image.network(
                  widget.url ?? '',
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return const SizedBox(
                        height: 300,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                ),
              ),
              formContent(context),
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: SizedBox(
          width: 500,
          height: 100,
          child: Container(
            color: Colors.blueGrey,
            child: TextButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  // First Save state (DTO)
                  formKey.currentState!.save();
                  // addDateToPostEntryValues();
                  newPost.imageUrl = widget.url ?? '';

                  // Save Entry to Database
                  await postService.uploadData(newPost);

                  uploadedDataSuccessful = true;

                  // Go back to prior page...
                  if (!mounted) return;
                  // Check if still mounted before setting state
                  // Navigator.of(context).popAndPushNamed(WasteListScreen.route);
                  Navigator.of(context).pop();
                }
              },
              child: const Icon(Icons.cloud_upload),
            ),
          ),
        ));
  }

  //--------------------------------------
  // Build FORM Layout Widget
  //--------------------------------------
  Widget formContent(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: quantityField(context),
        ),
      ]),
    );
  }

  //--------------------------------------
  // Build QUANTITY Field Widget
  //--------------------------------------
  Widget quantityField(BuildContext context) {
    return TextFormField(
        textAlign: TextAlign.center,
        // autofocus: true,
        decoration: const InputDecoration(
          hintText: 'Number of Wasted Items',
          hintStyle: TextStyle(
            fontSize: 30,
          ),
        ),
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 30),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        onSaved: (value) {
          newPost.quantity = int.parse(value ?? '-1');
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter the number of wasted items';
          } else if (int.parse(value) < 1) {
            return "Must be non-zero";
          } else {
            return null;
          }
        });
  }

  // //--------------------------------------
  // // Upload Data to Firebase
  // //--------------------------------------
  // void uploadData() async {
  //   final url = widget.url;
  //   LocationData loc = await retreiveLocation();
  //   double lat = loc.latitude as double;
  //   double long = loc.longitude as double;
  //   final weight = DateTime.now().millisecondsSinceEpoch % 1000;
  //   final title = 'Title $weight';
  //   FirebaseFirestore.instance.collection('posts-test').add({
  //     'weight': weight,
  //     'title': title,
  //     'url': url,
  //     'latitude': lat,
  //     'longitude': long,
  //   });
  // }

  // //--------------------------------------
  // // Build SAVE Button (Submit Form)
  // //--------------------------------------
  // Widget saveButton(BuildContext context) {
  //   // Get handle on parent Widget of a certain type...
  //   final JournalEntryListScreenState? journalList =
  //       context.findAncestorStateOfType<JournalEntryListScreenState>();

  //   return Padding(
  //     padding: const EdgeInsets.all(5),
  //     child: ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //         minimumSize: const Size(100, 40),
  //       ),
  //       onPressed: () async {
  //         if (formKey.currentState!.validate()) {
  //           // First Save state (DTO)
  //           formKey.currentState!.save();
  //           addDateToJournalEntryValues();

  //           // Save Entry to Database
  //           final databaseManager = DatabaseManager.getInstance();
  //           databaseManager.saveJournalEntry(dto: journalEntryFields);

  //           // Reload JournalList Widget
  //           if (journalList != null) {
  //             journalList.loadJournal();
  //           }

  //           // Go back to prior page...
  //           Navigator.of(context).popAndPushNamed(JournalEntryListScreen.route);
  //         }
  //       },
  //       child: const Text('Save'),
  //     ),
  //   );
  // }

  // void addDateToPostEntryValues() {
  //   postFields.date = DateTime.now();
  // }
}
