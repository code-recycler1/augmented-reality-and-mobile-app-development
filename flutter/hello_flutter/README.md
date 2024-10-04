# Hello Flutter App

This is a simple Flutter application created as part of a school course to demonstrate the basics of Flutter and Dart. The app displays a greeting message based on the time of day.

## Getting Started

### Prerequisites

- Flutter 3.9.16
- Dart SDK
- An IDE such as Visual Studio Code or Android Studio

## Project Structure

The project structure is organized as follows:

```text
lib/
├── main.dart
└── pages/
    └── home.dart
```

## Code Overview

### main.dart

The `main.dart` file contains the entry point of the application and sets up the `HelloFlutterApp` widget.

```dart
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
```

### home.dart

The `home.dart` file contains the `HomePage` widget, which displays a greeting message based on the time of day.

```dart
import 'package:flutter/material.dart';

// This is the main HomePage widget, which is stateless
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // The build method creates the UI of the HomePage widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold provides the basic structure of the screen
      appBar: AppBar(
        // The AppBar displays a title at the top of the screen
        title: const Text("Title in App Bar"),
      ),
      body: Material(
        // Sets the background color of the body to deep purple
        color: Colors.deepPurple,
        child: Center(
          // Centers the child widget (Text) within the body
          child: Text(
            sayHello(), // Calls the sayHello() method to display the greeting
            textDirection:
                TextDirection.ltr, // Sets text direction from left to right
            style: const TextStyle(
                color: Colors.white, fontSize: 36.0), // Applies text styling
          ),
        ),
      ),
    );
  }

  // Method to determine and return the appropriate greeting message
  String sayHello() {
    String hello;
    DateTime now = DateTime.now(); // Gets the current date and time
    int hour = now.hour; // Extracts the current hour

    // Determine the greeting message based on the current hour
    if (hour < 12) {
      hello = "Good Morning";
    } else if (hour < 18) {
      hello = "Good Afternoon";
    } else {
      hello = "Good Evening";
    }

    return hello; // Returns the selected greeting
  }
}
```

## Features

- Displays a greeting message based on the time of day.
- Utilizes Material Design for a clean and modern UI.

## Tips
- When nesting brackets, put a comma behind these brackets and press `alt-shift-f` to format your code.

## Official Documentation
For more information on Flutter and Dart, refer to the [Flutter - Dart API docs](https://api.flutter.dev/index.html).