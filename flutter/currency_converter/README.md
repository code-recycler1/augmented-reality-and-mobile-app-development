# Currency Converter

This project is a simple currency converter application built using **Flutter 3.19.6**. The app allows users to convert amounts between different currencies using a predefined list of exchange rates.

### Prerequisites

- Flutter 3.9.16
- Dart SDK
- Visual Studio Code or any other IDE of your choice

## Project Structure

The project structure is organized as follows:

```text
lib/
├── main.dart
|── models/
│    └── currency.dart
├── pages/
│    ├── converter.dart
│    └── example.dart
└── widgets/
     └── currencydropdownbutton.dart
assets/
├── CAD.png
├── CNY.png
├── EUR.png
├── GBP.png
├── INR.png
├── SGD.png
└── USD.png
```

- `main.dart`: Entry point of the application. Sets up the app and its theme.
- `pages/converter.dart`: Contains the main UI and logic for the currency converter.
- `pages/example.dart`: Contains a first example of a stateful widget and is the start of the currency converter app.
- `widgets/currencydropdownbutton.dart`: Custom widget for the currency selection dropdown.
- `models/currency.dart`: Model class representing a currency.

## Code Overview

### main.dart

```dart
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
```

### currency.dart

```dart
class Currency {
  String name; // Full name of the currency
  String shortname; // Abbreviation of the currency (e.g., USD)
  double _value; // Conversion rate

  Currency(this.name, this.shortname, this._value);

  // Getter for the conversion value
  double get value {
    return _value;
  }

  // Setter for the conversion value, ensures it's positive
  set value(double value) {
    if (value > 0) {
      _value = value;
    }
  }
}
```

### converter.dart

```dart
import 'package:flutter/material.dart';
import 'package:currency_converter/models/currency.dart';
import 'package:currency_converter/widgets/currencydropdownbutton.dart';

// Stateful widget for currency conversion
class ConverterPage extends StatefulWidget {
  const ConverterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConverterPageState();
}

// State class for the ConverterPage
class _ConverterPageState extends State<ConverterPage> {
  // TextController to handle amount input
  TextEditingController amountController = TextEditingController();

  // Variables to hold the input amount and converted amount
  String _fromamount = "";
  String _toamount = "";
  late Currency _from; // Selected currency to convert from
  late Currency _to; // Selected currency to convert to

  // List of available currencies with conversion rates
  final _currencies = [
    Currency('US Dollar', 'USD', 1),
    Currency('Euro', 'EUR', 1.16),
    Currency('British Pound', 'GBP', 1.2715),
    Currency('Indian Rupee', 'INR', 0.0135),
    Currency('Chinese yuan', 'CNY', 0.1466),
    Currency('Canadian Dollar', 'CAD', 0.7458),
    Currency('Singapore Dollar', 'SGD', 0.7268)
  ];

  // Initialize default selected currencies
  @override
  void initState() {
    super.initState();
    _from = _currencies[1]; // Default 'from' currency is Euro
    _to = _currencies[0]; // Default 'to' currency is US Dollar
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.bodyText1;
    double formPadding = 5.0; // Padding for form elements
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency Converter"), // AppBar title
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            // TextField to input the amount to be converted
            Padding(
              padding: EdgeInsets.only(bottom: formPadding, top: formPadding),
              child: TextField(
                controller: amountController,
                style: textStyle,
                keyboardType: TextInputType.number, // Allows numeric input
                decoration: InputDecoration(
                  hintText: "e.g. 17.85", // Placeholder text
                  labelText: "Amount", // Label for input
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            // Dropdown to select the 'From' currency
            Padding(
              padding: EdgeInsets.only(bottom: formPadding, top: formPadding),
              child: CurrencyDropdownButtonWidget(
                  labelText: "From", // Label for the dropdown
                  selectedCurrency: _from,
                  currencies: _currencies, // List of currencies
                  onCurrencySelected: (currency) {
                    _onFromChanged(currency);
                  }),
            ),
            // Dropdown to select the 'To' currency
            Padding(
              padding: EdgeInsets.only(bottom: formPadding, top: formPadding),
              child: CurrencyDropdownButtonWidget(
                  labelText: "To",
                  selectedCurrency: _to,
                  currencies: _currencies,
                  onCurrencySelected: (currency) {
                    _onToChanged(currency);
                  }),
            ),
            Container(
              height: formPadding,
            ),
            // Row with 'Convert' and 'Reset' buttons
            Row(children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _calculate(); // Calculate conversion
                  },
                  child: const Text(
                    'Convert',
                    textScaleFactor: 1.5,
                  ),
                ),
              ),
              Container(
                width: formPadding,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _reset(); // Reset input and output fields
                  },
                  child: const Text(
                    'Reset',
                    textScaleFactor: 1.5,
                  ),
                ),
              ),
            ]),
            // Display the input amount and currency after conversion
            Container(
              margin: EdgeInsets.only(top: formPadding * 5),
              child: Text(
                _fromamount,
                style: textStyle,
                textScaleFactor: 1.2,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: formPadding),
              child: Text(
                _toamount,
                style: textStyle,
                textScaleFactor: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reset the fields and clear the input
  void _reset() {
    amountController.text = '';
    setState(() {
      _fromamount = '';
      _toamount = '';
    });
  }

  // Perform the currency conversion
  void _calculate() {
    try {
      double amount = double.parse(amountController.text); // Get input amount
      double result = amount * _from.value / _to.value; // Conversion formula

      // Update UI with the converted amount
      setState(() {
        _fromamount = '${amount.toStringAsFixed(3)} ${_from.shortname} =';
        _toamount = '${result.toStringAsFixed(3)} ${_to.shortname}';
      });
    } catch (e) {
      // Handle invalid input with a message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid number')),
      );
    }
  }

  // Update the 'from' currency
  void _onFromChanged(Currency currency) {
    setState(() {
      _from = currency;
    });
  }

  // Update the 'to' currency
  void _onToChanged(Currency currency) {
    setState(() {
      _to = currency;
    });
  }
}
```

### example.dart

```dart
import 'package:flutter/material.dart';

// StatefulWidget for the example page
class ExamplePage extends StatefulWidget {
  const ExamplePage({Key? key}) : super(key: key);

  // Creates the mutable state for the widget
  @override
  State<StatefulWidget> createState() => _ExamplePageState();
}

// The state class where the logic and UI updates are handled
class _ExamplePageState extends State<ExamplePage> {
  String _name = ''; // Variable to store the name entered by the user

  // Builds the UI layout of the page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Example"), // AppBar title
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0), // Padding around the content
        child: Column(
          children: <Widget>[
            // TextField for user input
            TextField(
              decoration: const InputDecoration(
                  hintText: 'Please enter your name'), // Placeholder text
              onChanged: (String string) {
                // Updates _name state when the input changes
                setState(() {
                  _name = string;
                });
              },
            ),
            // Container for displaying the greeting message
            Container(
              padding: const EdgeInsets.only(top: 15.0), // Padding on top
              child: Text("Hello $_name!"), // Displays the entered name
            ),
          ],
        ),
      ),
    );
  }
}
```

### currencydropdownbutton.dart

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:currency_converter/models/currency.dart';
import 'package:flutter/widgets.dart';

// Callback type for selecting a currency
typedef MyCallback = void Function(Currency currency);

// Dropdown widget for selecting a currency
class CurrencyDropdownButtonWidget extends StatelessWidget {
  final String labelText; // Label for the dropdown
  final Currency selectedCurrency; // Currently selected currency
  final List<Currency> currencies; // List of available currencies
  final MyCallback onCurrencySelected; // Callback when a currency is selected

  const CurrencyDropdownButtonWidget({
    Key? key,
    required this.labelText,
    required this.selectedCurrency,
    required this.currencies,
    required this.onCurrencySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.bodyText1;
    return InputDecorator(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10), // Padding inside dropdown
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: DropdownButton<Currency>(
        isExpanded: true, // Expands dropdown to fit content
        items: currencies.map((Currency currency) {
          return DropdownMenuItem<Currency>(
            value: currency,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Image of the currency's flag
                Image(
                    image: AssetImage("assets/${currency.shortname}.png"),
                    width: 40.0,
                    height: 40.0),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                ),
                // Display the short name and full name of the currency
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        child: Text(
                      currency.shortname, // Currency short name
                      textScaleFactor: 1.3,
                    )),
                    Flexible(child: Text(currency.name)), // Full name
                  ],
                )
              ],
            ),
          );
        }).toList(),
        value: selectedCurrency,
        style: textStyle,
        onChanged: (value) {
          onCurrencySelected(value!); // Calls the callback on selection
        },
        underline: const SizedBox.shrink(), // Hides the underline
      ),
    );
  }
}
```
## Assets

<img src="./assets/CAD.png" alt="CAD" width="100"/>
<img src="./assets/CNY.png" alt="CNY" width="100"/>
<img src="./assets/EUR.png" alt="EUR" width="100"/>
<img src="./assets/GBP.png" alt="GBP" width="100"/>
<img src="./assets/INR.png" alt="INR" width="100"/>
<img src="./assets/SGD.png" alt="SGD" width="100"/>
<img src="./assets/USD.png" alt="USD" width="100"/>
