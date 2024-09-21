import 'package:flutter/material.dart';

class CircleImageWidget extends StatelessWidget {
  final String imageName;

  const CircleImageWidget({Key? key, required this.imageName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AssetImage avatarAsset = AssetImage(imageName);
    return CircleAvatar(
      radius: 100.0,
      backgroundImage: avatarAsset,
    );
  }
}
