import 'package:flutter/material.dart';
import 'pages/post_list.dart';

// Entry point of the application
void main() async {
  runApp(const MyApp());
}

// Root widget of the app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner in the app
      title: 'NewYorkTimesApp', // App title
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.blueGrey), // Theme color
      ),
      home: const PostListPage(), // Main page displaying a list of posts
    );
  }
}
