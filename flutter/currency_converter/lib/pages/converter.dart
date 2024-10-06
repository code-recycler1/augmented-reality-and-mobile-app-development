import 'package:flutter/material.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConverterPageState();
}

class _ConverterPageState extends State {
  String _name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency Converter"),
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration:
                  const InputDecoration(hintText: 'Please enter your name'),
              onChanged: (String string) {
                setState(() {
                  _name = string;
                });
              },
            ),
            Container(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text("Hello $_name!"),
            ),
          ],
        ),
      ),
    );
  }
}
