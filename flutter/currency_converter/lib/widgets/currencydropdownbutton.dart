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
