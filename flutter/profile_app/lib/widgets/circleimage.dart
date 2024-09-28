import 'package:flutter/material.dart';

// A stateless widget to display a circular image
class CircleImageWidget extends StatelessWidget {
  final String imageName; // Path to the image asset

  const CircleImageWidget({Key? key, required this.imageName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AssetImage avatarAsset = AssetImage(imageName); // Load the image asset
    return CircleAvatar(
      radius: 100.0, // Sets the size of the circle
      backgroundImage: avatarAsset, // Displays the loaded image
    );
  }
}
