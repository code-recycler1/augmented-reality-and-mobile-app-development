// Import necessary packages
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flags/models/country.dart';
import 'package:flags/widgets/flagimage.dart';

// QuizPage is a stateful widget to handle the quiz logic
class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

// State class for QuizPage
class _QuizPageState extends State<QuizPage> {
  final double _padding = 15.0; // Padding used in layout
  String _textAnswer = ""; // The current correct answer (country name)
  int _score = 0; // Current score of the player
  late int _correctAnswer; // Index of the correct answer
  final List<String> _flags = ["", "", ""]; // Stores the flag options

  // List of countries for the quiz
  final List<Country> _countries = [
    Country('ar', 'Argentina'),
    Country('br', 'Brazil'),
    Country('ca', 'Canada'),
    Country('es', 'Spain'),
    Country('mx', 'Mexico'),
    Country('pt', 'Portugal'),
    Country('tr', 'Turkey'),
    Country('gr', 'Greece'),
    Country('eg', 'Egypt'),
    Country('au', 'Australia'),
    Country('ci', 'Côte d\'Ivoire'),
    Country('cm', 'Cameroon'),
    Country('cy', 'Cyprus'),
    Country('gh', 'Ghana'),
    Country('jm', 'Jamaica'),
    Country('jp', 'Japan'),
    Country('kz', 'Kazachstan'),
    Country('mt', 'Malta'),
    Country('sy', 'Syria'),
    Country('ch', 'Switzerland')
  ];

  @override
  void initState() {
    super.initState();
    _createQuestion(); // Generate the first question when the page loads
  }

  // Function to shuffle a list of items (used for randomizing the options)
  List shuffle(List items) {
    var random = Random();

    for (var i = items.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flags"), // Title in the AppBar
        backgroundColor: Colors.blue, // AppBar background color
        foregroundColor: Colors.white, // Text color
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0), // Padding around the body
        child: Column(
          children: <Widget>[
            Container(
              height: 80, // Empty space for spacing
            ),
            Padding(
              padding: EdgeInsets.only(bottom: _padding, top: _padding),
              child: const Text(
                "Pick the right flag!", // Instruction for the player
                textScaleFactor: 2, // Scales the text size
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2 * _padding, top: 3 * _padding),
              child: Text(
                _textAnswer, // Display the name of the country to guess
                textScaleFactor: 4,
              ),
            ),
            // Row to display the three flag options
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlagImage(
                    flag: _flags[0], // First flag option
                    onPressed: (flag) {
                      _checkResult(flag); // Check if this is the correct flag
                    }),
                FlagImage(
                    flag: _flags[1], // Second flag option
                    onPressed: (flag) {
                      _checkResult(flag);
                    }),
                FlagImage(
                    flag: _flags[2], // Third flag option
                    onPressed: (flag) {
                      _checkResult(flag);
                    }),
              ],
            ),
            Container(
              height: 80, // Empty space for spacing
            ),
            // Display the current score
            Padding(
                padding: EdgeInsets.only(top: 3 * _padding),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Score : ", // Score label
                        textScaleFactor: 3,
                      ),
                      Text(
                        _score.toString(), // Display the score as a string
                        textScaleFactor: 3,
                      ),
                    ])),
          ],
        ),
      ),
    );
  }

  // Function to create a new question with random flags
  void _createQuestion() {
    var random = Random();
    List countries = shuffle(_countries); // Shuffle the list of countries

    _correctAnswer =
        random.nextInt(3); // Randomly pick the correct answer index
    setState(() {
      _textAnswer =
          countries[_correctAnswer].name; // Set the correct country name
      // Set the flag options
      _flags[0] = countries[0].flag;
      _flags[1] = countries[1].flag;
      _flags[2] = countries[2].flag;
    });
  }

  // Function to check if the selected flag is correct
  void _checkResult(String answer) {
    if (_textAnswer == _countries.singleWhere((c) => (c.flag == answer)).name) {
      setState(() {
        _score = _score + 1; // Increase the score if the answer is correct
      });
    }

    _createQuestion(); // Generate a new question after checking the result
  }
}
