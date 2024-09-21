import 'package:flutter/material.dart';

class NumberLabelWidget extends StatelessWidget {
  final String text;
  final int count;

  const NumberLabelWidget({Key? key, required this.text, required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            count.toString(),
            style: const TextStyle(
              fontSize: 20.0,
              decoration: TextDecoration.none,
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            text.toUpperCase(),
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
