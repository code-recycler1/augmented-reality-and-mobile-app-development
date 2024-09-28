import 'package:flutter/material.dart';

// Typedef for the callback function when the button is pressed
typedef MyCallback = void Function(String text);

// A stateless widget that displays an icon button with text
class IconButtonWidget extends StatelessWidget {
  final String text; // Text label for the button
  final IconData icon; // Icon displayed on the button
  final MyCallback
      onButtonPressed; // Callback function when the button is pressed

  const IconButtonWidget(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center, // Centers the icon and text
        children: <Widget>[
          Icon(icon), // Displays the icon
          const SizedBox(
            width: 5, // Adds space between the icon and text
          ),
          Text(text.toUpperCase()) // Displays the text in uppercase
        ],
      ),
      onPressed: () {
        onButtonPressed(
            text); // Executes the callback when the button is pressed
      },
    );
  }
}
