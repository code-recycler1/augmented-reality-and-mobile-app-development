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
