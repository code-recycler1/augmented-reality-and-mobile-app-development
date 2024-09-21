import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        alignment: Alignment.center,
        color: Colors.blue[400],
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "PewDiePie",
              style: TextStyle(
                  fontSize: 40.0,
                  decoration: TextDecoration.none,
                  fontFamily: 'SansitaSwashed',
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
            SizedBox(height: 30),
            Text(
              "Swedish YouTuber, comedian, gamer and philanthropist",
              style: TextStyle(
                  fontSize: 20.0,
                  decoration: TextDecoration.none,
                  fontFamily: 'SansitaSwashed',
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Row(
              children: <Widget>[
                Text(
                  "12035 posts",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "1205021 followers",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "2563 following",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
