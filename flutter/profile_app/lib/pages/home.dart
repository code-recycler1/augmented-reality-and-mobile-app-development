import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          alignment: Alignment.center,
          // width: 190.0,
          // height: 250.0,
          // margin: const EdgeInsets.all(50.0),
          color: Colors.blue[400],
          child: const Text("PewDiePie"),
        ),
      ),
    );
  }
}
