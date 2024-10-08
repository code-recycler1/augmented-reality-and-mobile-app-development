import 'package:flutter/material.dart';
import 'package:one_two_three_v2/widgets/numberbutton.dart';
import 'dart:math';

// HomePage widget, displays the main layout of the app
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _operation;
  late int _result;
  String _answer = ""; // User's answer
  int _score = 0; // Current score

  @override
  void initState() {
    super.initState();
    _generateNewOperation(); // Generate a random operation when the app opens
  }

  // Handles the button press, updates the answer
  void _handleButtonPressed(String number) {
    setState(() {
      if (number == 'X') {
        if (_answer.isNotEmpty) {
          _answer = _answer.substring(0, _answer.length - 1);
        }
      } else if (number == '?') {
        _checkAnswer();
      } else {
        _answer += number;
      }
    });
  }

  // Checks if the answer is correct and updates the score
  void _checkAnswer() {
    if (int.tryParse(_answer) == _result) {
      setState(() {
        _score++;
        _generateNewOperation();
      });
    } else {
      setState(() {
        _answer = "";
      });
    }
  }

  // Generates a new operation
  void _generateNewOperation() {
    final random = Random();
    int num1, num2, operationType;

    do {
      num1 = random.nextInt(50) + 1; // Random number between 1 and 50
      num2 = random.nextInt(50) + 1; // Random number between 1 and 50
      operationType =
          random.nextInt(4); // Random operation type (0: +, 1: -, 2: *, 3: /)

      switch (operationType) {
        case 0:
          _operation = "$num1 + $num2 = ";
          _result = num1 + num2;
          break;
        case 1:
          _operation = "$num1 - $num2 = ";
          _result = num1 - num2;
          break;
        case 2:
          _operation = "$num1 * $num2 = ";
          _result = num1 * num2;
          break;
        case 3:
          if (num2 != 0 && num1 % num2 == 0) {
            _operation = "$num1 / $num2 = ";
            _result = num1 ~/ num2;
          } else {
            _result = 101; // Force regeneration if division is not valid
          }
          break;
      }
    } while (_result >= 100 ||
        _result < 0); // Ensure the result is between 0 and 100

    _answer = "";
  }

  // Builds the UI layout of the HomePage
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'One Two Three V2', // App title text
          style: TextStyle(color: Colors.white, fontFamily: 'Marcellus'),
        ),
        backgroundColor: Colors.blue, // AppBar background color
      ),
      body: Container(
        alignment: Alignment.center, // Centers the content
        color: Colors.white, // Background color of the body
        padding: const EdgeInsets.all(15.0), // Padding around the content
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // Spaces children evenly
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _operation, // Displays the operation
                  style: const TextStyle(fontFamily: 'Marcellus', fontSize: 50),
                ),
                Text(
                  _answer, // Displays the answer
                  style: const TextStyle(fontFamily: 'Marcellus', fontSize: 50),
                )
              ],
            ),
            Column(
              children: [
                // First row of number buttons (1, 2, 3)
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Centers buttons
                  children: [
                    NumberButtonWidget(
                        number: '1', onButtonPressed: _handleButtonPressed),
                    NumberButtonWidget(
                        number: '2', onButtonPressed: _handleButtonPressed),
                    NumberButtonWidget(
                        number: '3', onButtonPressed: _handleButtonPressed),
                  ],
                ),
                // Second row of number buttons (4, 5, 6)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NumberButtonWidget(
                        number: '4', onButtonPressed: _handleButtonPressed),
                    NumberButtonWidget(
                        number: '5', onButtonPressed: _handleButtonPressed),
                    NumberButtonWidget(
                        number: '6', onButtonPressed: _handleButtonPressed),
                  ],
                ),
                // Third row of number buttons (7, 8, 9)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NumberButtonWidget(
                        number: '7', onButtonPressed: _handleButtonPressed),
                    NumberButtonWidget(
                        number: '8', onButtonPressed: _handleButtonPressed),
                    NumberButtonWidget(
                        number: '9', onButtonPressed: _handleButtonPressed),
                  ],
                ),
                // Last row of buttons (0, X, ?)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NumberButtonWidget(
                        number: '0', onButtonPressed: _handleButtonPressed),
                    NumberButtonWidget(
                        number: 'X', onButtonPressed: _handleButtonPressed),
                    NumberButtonWidget(
                        number: '?', onButtonPressed: _handleButtonPressed),
                  ],
                ),
              ],
            ),
            Text(
              'Score: $_score', // Displays the current score
              style: const TextStyle(fontFamily: 'Marcellus', fontSize: 50),
            ),
          ],
        ),
      ),
    );
  }
}
