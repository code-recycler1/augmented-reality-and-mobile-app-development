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
