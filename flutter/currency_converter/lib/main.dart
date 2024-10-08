import 'package:flutter/material.dart';
import 'package:currency_converter/pages/converter.dart';

void main() {
  runApp(const CurrencyConverterApp());
}

// Root of the Currency Converter App
class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner
      title: 'Currency Converter', // App title
      theme: ThemeData(
        primarySwatch: Colors.green, // Sets theme color
      ),
      home: const ConverterPage(), // Home page is the ConverterPage widget
    );
  }
}
