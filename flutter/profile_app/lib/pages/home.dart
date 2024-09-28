import 'package:flutter/material.dart';
import 'package:profile_app/widgets/numberlabel.dart';
import 'package:profile_app/widgets/circleimage.dart';
import 'package:profile_app/widgets/iconbutton.dart';

// HomePage widget representing the main screen
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"), // AppBar title
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0), // Adds padding around the content
        alignment: Alignment.center, // Centers the content
        color: Colors.blue[400], // Sets the background color
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centers the column's children
          children: <Widget>[
            const CircleImageWidget(
              imageName: "assets/pewdiepie.png", // Displays a circular image
            ),
            const SizedBox(height: 30), // Adds vertical spacing
            const Text(
              "PewDiePie", // Displays the profile name
              style: TextStyle(
                  fontSize: 40.0,
                  decoration: TextDecoration.none,
                  fontFamily: 'SansitaSwashed',
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
            const SizedBox(height: 30), // Adds vertical spacing
            const Text(
              "Swedish YouTuber, comedian, gamer and philanthropist",
              style: TextStyle(
                  fontSize: 20.0,
                  decoration: TextDecoration.none,
                  fontFamily: 'SansitaSwashed',
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
              textAlign: TextAlign.center, // Centers the text
            ),
            const Divider(height: 50.0, color: Colors.white), // Divider line
            const Row(children: <Widget>[
              // Displays three NumberLabelWidgets
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
            const Divider(height: 50.0, color: Colors.white), // Divider line
            IconButtonWidget(
                icon: Icons.person,
                text: "follow",
                onButtonPressed: (text) {
                  _follow(text,
                      context); // Calls the _follow method on button press
                }),
          ],
        ),
      ),
    );
  }

  // Private method to display an alert dialog when the follow button is pressed
  void _follow(String text, BuildContext context) {
    var alert = AlertDialog(
      title: Text(text.toUpperCase()), // Display the button text as uppercase
      content: const Text("Registration successfully completed!"),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}
