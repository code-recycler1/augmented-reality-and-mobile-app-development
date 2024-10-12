// Import necessary packages
import 'package:flutter/material.dart';

// Type definition for a callback when a flag is selected
typedef MyCallback = void Function(String flag);

// Stateless widget to display the flag image
class FlagImage extends StatelessWidget {
  final String flag; // The flag image file (e.g., 'ar' for Argentina)
  final MyCallback onPressed; // Callback function when the flag is tapped

  const FlagImage({super.key, required this.flag, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // Load the image of the flag from the assets folder
    AssetImage asset = AssetImage("assets/$flag.png");
    Image image = Image(image: asset, width: 100.0, height: 100.0);
    return GestureDetector(
      // Detect tap on the flag and trigger the callback
      onTap: () {
        onPressed(flag);
      },
      // Container to wrap the image
      child: Container(
        padding: const EdgeInsets.only(top: 20.0),
        child: image,
      ),
    );
  }
}
