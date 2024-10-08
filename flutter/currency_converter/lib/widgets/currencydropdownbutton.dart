import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:currency_converter/models/currency.dart';
import 'package:flutter/widgets.dart';

typedef MyCallback = void Function(Currency currency);

class CurrencyDropdownButtonWidget extends StatelessWidget {
  final String labelText;
  final Currency selectedCurrency;
  final List<Currency> currencies;
  final MyCallback onCurrencySelected;

  const CurrencyDropdownButtonWidget(
      {Key? key,
      required this.labelText,
      required this.selectedCurrency,
      required this.currencies,
      required this.onCurrencySelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.bodyText1;
    return InputDecorator(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: DropdownButton<Currency>(
        isExpanded: true,
        items: currencies.map((Currency currency) {
          return DropdownMenuItem<Currency>(
            value: currency,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image(
                    image: AssetImage("assets/${currency.shortname}.png"),
                    width: 40.0,
                    height: 40.0),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        child: Text(
                      currency.shortname,
                      textScaleFactor: 1.3,
                    )),
                    Flexible(child: Text(currency.name)),
                  ],
                )
              ],
            ),
          );
        }).toList(),
        value: selectedCurrency,
        style: textStyle,
        onChanged: (value) {
          onCurrencySelected(value!);
        },
        underline: const SizedBox.shrink(),
      ),
    );
  }
}
