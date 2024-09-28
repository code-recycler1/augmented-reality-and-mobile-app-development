import 'package:flutter/material.dart';
import 'package:profile_app/pages/home.dart';

// Entry point of the application
void main() {
  runApp(const ProfileApp()); // Run the ProfileApp as the root widget
}

// Main ProfileApp widget
class ProfileApp extends StatelessWidget {
  const ProfileApp({Key? key}) : super(key: key);

  // The build method creates the UI structure of the ProfileApp
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      title: 'Profile', // Sets the application title
      theme: ThemeData(
        primarySwatch: Colors.blue, // Sets the primary theme color
      ),
      home: const HomePage(), // Sets HomePage as the initial screen
    );
  }
}
