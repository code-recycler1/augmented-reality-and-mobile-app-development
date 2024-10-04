import 'package:flutter/material.dart';
import 'package:one_two_three/widgets/numberbutton.dart';

// HomePage widget, displays the main layout of the app
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // Builds the UI layout of the HomePage
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'One Two Three', // App title text
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
            const Text(
              '34 + 22 =', // Example equation text
              style: TextStyle(fontFamily: 'Marcellus', fontSize: 50),
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
            const Text(
              'Score: 2', // Example score display
              style: TextStyle(fontFamily: 'Marcellus', fontSize: 50),
            ),
          ],
        ),
      ),
    );
  }

  // Handles the button press, prints the pressed number to the console
  void _handleButtonPressed(String number) {
    print('Button pressed: $number');
  }
}
