import 'package:flutter/material.dart';

// StatefulWidget for the example page
class ExamplePage extends StatefulWidget {
  const ExamplePage({Key? key}) : super(key: key);

  // Creates the mutable state for the widget
  @override
  State<StatefulWidget> createState() => _ExamplePageState();
}

// The state class where the logic and UI updates are handled
class _ExamplePageState extends State<ExamplePage> {
  String _name = ''; // Variable to store the name entered by the user

  // Builds the UI layout of the page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Example"), // AppBar title
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0), // Padding around the content
        child: Column(
          children: <Widget>[
            // TextField for user input
            TextField(
              decoration: const InputDecoration(
                  hintText: 'Please enter your name'), // Placeholder text
              onChanged: (String string) {
                // Updates _name state when the input changes
                setState(() {
                  _name = string;
                });
              },
            ),
            // Container for displaying the greeting message
            Container(
              padding: const EdgeInsets.only(top: 15.0), // Padding on top
              child: Text("Hello $_name!"), // Displays the entered name
            ),
          ],
        ),
      ),
    );
  }
}
