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
import 'package:flutter/material.dart';
import './pages/home.dart';

void main() => runApp(const HelloFlutterApp());

class HelloFlutterApp extends StatelessWidget {
  const HelloFlutterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hello Flutter App',
      home: HomePage(),
    );
  }
}

```

### home.dart

The `home.dart` file contains the `HomePage` widget, which displays a greeting message based on the time of day.

```dart
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Title in App Bar"),
      ),
      body: Material(
        color: Colors.deepPurple,
        child: Center(
          child: Text(
            sayHello(),
            textDirection: TextDirection.ltr,
            style: const TextStyle(color: Colors.white, fontSize: 36.0),
          ),
        ),
      ),
    );
  }

  String sayHello() {
    String hello;
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour < 12) {
      hello = "Good Morning";
    } else if (hour < 18) {
      hello = "Good Afternoon";
    } else {
      hello = "Good Evening";
    }

    return hello;
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