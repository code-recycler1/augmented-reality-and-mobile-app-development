import 'package:flutter/material.dart'; // Importing the Flutter material package for UI components
import './pages/home.dart'; // Importing the HomePage widget from the pages directory

// The main function is the entry point of the Flutter application
void main() => runApp(
    const HelloFlutterApp()); // Running the app with HelloFlutterApp as the root widget

// The main application widget, which is a stateless widget
class HelloFlutterApp extends StatelessWidget {
  const HelloFlutterApp({Key? key}) : super(key: key);

  // The build method constructs the UI of the HelloFlutterApp widget
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner:
          false, // Disables the debug banner in the top-right corner
      title: 'Hello Flutter App', // Sets the title of the application
      home: HomePage(), // Sets HomePage as the default screen of the app
    );
  }
}
