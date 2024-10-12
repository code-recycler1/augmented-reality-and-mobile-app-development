// Import necessary packages
import 'package:flags/pages/quiz.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FlagsApp()); // Entry point of the application
}

// Root of the Flags App
class FlagsApp extends StatelessWidget {
  const FlagsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      title: 'Flags', // Title of the app
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), // App theme
      ),
      home: const QuizPage(), // Default page is QuizPage
    );
  }
}
