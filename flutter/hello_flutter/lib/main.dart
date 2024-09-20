import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Hello Flutter App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Title in App Bar"),
        ),
        body: const Material(
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
    ),
  );
}
