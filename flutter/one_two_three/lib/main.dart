import 'package:flutter/material.dart';
import './pages/home.dart';

// Entry point of the app, runs the OneTwoThreeApp widget
void main() => runApp(const OneTwoThreeApp());

// Main application widget
class OneTwoThreeApp extends StatelessWidget {
  const OneTwoThreeApp({Key? key}) : super(key: key);

  // Defines the structure of the app
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      title: 'One Two Three', // Sets the app's title
      home: HomePage(), // HomePage widget as the home screen
    );
  }
}
