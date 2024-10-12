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
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
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
