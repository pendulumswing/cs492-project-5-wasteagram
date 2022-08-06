import 'package:flutter/material.dart';
import '../models/food_waste_post.dart';

class WasteDetailScreen extends StatelessWidget {
  static const route = '/waste_detail';
  final String title = 'Waste Detail';
  final FoodWastePost post;
  const WasteDetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wasteagram'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //------------------
          // Date
          //------------------
          Text(post.getFormattedDateShort,
              style: Theme.of(context).textTheme.headline4),

          //------------------
          // Image
          //------------------
          SizedBox(
            height: 300,
            width: 800,
            child: Image.network(
              post.imageUrl,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const SizedBox(
                    width: 800,
                    height: 300,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
          ),

          //------------------
          // Quantity
          //------------------
          Text("${post.quantity.toString()} ${post.quantity > 1 ? 'items' : 'item'}",
              style: Theme.of(context).textTheme.headline4),

          //------------------
          // Location (GPS Coordinates)
          //------------------
          Text(
            'Location: \n(${post.latitude}, ${post.longitude})',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
