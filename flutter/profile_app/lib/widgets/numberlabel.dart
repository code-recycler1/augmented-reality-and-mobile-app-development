import 'package:flutter/material.dart';

// A stateless widget that displays a count with a label
class NumberLabelWidget extends StatelessWidget {
  final String text; // Label text
  final int count; // Numerical count to display

  const NumberLabelWidget({Key? key, required this.text, required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            count.toString(), // Display the count as a string
            style: const TextStyle(
              fontSize: 20.0,
              decoration: TextDecoration.none,
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            text.toUpperCase(), // Display the label text in uppercase
            style: const TextStyle(
              fontSize: 20.0,
              decoration: TextDecoration.none,
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
