import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Hello Flutter App',
      home: Material(
        color: Colors.deepPurple,
        child: Center(
          child: Text(
            "Hello Flutter!",
            textDirection: TextDirection.ltr,
            style: TextStyle(color: Colors.white, fontSize: 36.0),
          ),
        ),
      ),
    ),
  );
}
