import 'package:flutter/material.dart';

// A widget representing a number button
class NumberButtonWidget extends StatelessWidget {
  final String number; // The number displayed on the button
  final void Function(String) onButtonPressed; // Callback for button press

  const NumberButtonWidget({
    Key? key,
    required this.number, // The number is required
    required this.onButtonPressed, // The onButtonPressed callback is required
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0), // Padding around the button
      child: ElevatedButton(
        onPressed: () =>
            onButtonPressed(number), // Calls the callback with the number
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Button background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Rounded button corners
          ),
          minimumSize: const Size(150, 80), // Sets minimum size for the button
        ),
        child: Text(
          number, // Displays the number on the button
          style: const TextStyle(
              color: Colors.white, fontFamily: 'Marcellus', fontSize: 24),
        ),
      ),
    );
  }
}
