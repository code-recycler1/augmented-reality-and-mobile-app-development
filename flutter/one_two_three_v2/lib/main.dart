import 'package:flutter/material.dart';
import './pages/home.dart';

// Entry point of the app, runs the OneTwoThreeV2App widget
void main() => runApp(const OneTwoThreeV2App());

// Main application widget
class OneTwoThreeV2App extends StatelessWidget {
  const OneTwoThreeV2App({Key? key}) : super(key: key);

  // Defines the structure of the app
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      title: 'One Two Three V2', // Sets the app's title
      home: HomePage(), // HomePage widget as the home screen
    );
  }
}
