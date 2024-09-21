import 'package:flutter/material.dart';
import 'package:profile_app/widgets/numberlabel.dart';
import 'package:profile_app/widgets/circleimage.dart';
import 'package:profile_app/widgets/iconbutton.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleImageWidget(
              imageName: "assets/pewdiepie.png",
            ),
            const SizedBox(height: 30),
            const Text(
              "PewDiePie",
              style: TextStyle(
                  fontSize: 40.0,
                  decoration: TextDecoration.none,
                  fontFamily: 'SansitaSwashed',
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
            const SizedBox(height: 30),
            const Text(
              "Swedish YouTuber, comedian, gamer and philanthropist",
              style: TextStyle(
                  fontSize: 20.0,
                  decoration: TextDecoration.none,
                  fontFamily: 'SansitaSwashed',
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const Divider(height: 50.0, color: Colors.white),
            const Row(children: <Widget>[
              NumberLabelWidget(
                count: 12035,
                text: "posts",
              ),
              NumberLabelWidget(
                count: 1205021,
                text: "followers",
              ),
              NumberLabelWidget(
                count: 2563,
                text: "following",
              ),
            ]),
            const Divider(height: 50.0, color: Colors.white),
            IconButtonWidget(
                icon: Icons.person,
                text: "follow",
                onButtonPressed: (text) {
                  _follow(text, context);
                }),
          ],
        ),
      ),
    );
  }

  void _follow(String text, BuildContext context) {
    var alert = AlertDialog(
      title: Text(text.toUpperCase()),
      content: const Text("Registration successfully completed!"),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}
