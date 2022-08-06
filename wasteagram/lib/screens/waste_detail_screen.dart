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
      body: Container(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(post.getFormattedDateShort,
                style: Theme.of(context).textTheme.headline4),
            Image.network(
              post.imageUrl,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const SizedBox(
                    width: 800,
                    height: 300,
                    child: Center(child: CircularProgressIndicator()),
                    // child: Center(child: LinearProgressIndicator()),
                  );
                }
              },
            ),
            Text(post.quantity.toString(),
                style: Theme.of(context).textTheme.headline4),
            Text(
              'Location: \n(${post.latitude}, ${post.longitude})',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
