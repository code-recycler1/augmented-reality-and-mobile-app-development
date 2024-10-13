import 'package:flutter/material.dart';

// Type definition for the callback function when a post is tapped
typedef MyCallback = void Function();

// Widget representing a single post tile
class PostTile extends StatelessWidget {
  final String title, imageUrl, abstract; // Post details
  final MyCallback onTapped; // Callback function for tap events

  const PostTile({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.abstract,
    required this.onTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapped(); // Execute the callback when the tile is tapped
      },
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius:
                BorderRadius.circular(10.0), // Rounded corners for the image
            child: Image.network(
              imageUrl, // Display the post image
              height: 200,
              width: MediaQuery.of(context).size.width, // Use full width
              fit: BoxFit.cover, // Cover the available space
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title, // Display post title
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          Text(
            abstract, // Display post abstract
            style: const TextStyle(color: Colors.black54, fontSize: 14),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
