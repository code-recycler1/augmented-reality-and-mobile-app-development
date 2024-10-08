import 'package:flutter/material.dart';
import 'package:currency_converter/models/currency.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConverterPageState();
}

class _ConverterPageState extends State {
  TextEditingController amountController = TextEditingController();

  String _fromamount = "";
  String _toamount = "";
  late Currency _from;
  late Currency _to;

  final _currencies = [
    Currency('US Dollar', 'USD', 1),
    Currency('Euro', 'EUR', 1.16),
    Currency('British Pound', 'GBP', 1.2715),
    Currency('Indian Rupee', 'INR', 0.0135),
    Currency('Chinese yuan', 'CNY', 0.1466),
    Currency('Canadian Dollar', 'CAD', 0.7458),
    Currency('Singapore Dollar', 'SGD', 0.7268)
  ];

  @override
  void initState() {
    super.initState();
    _from = _currencies[1];
    _to = _currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.bodyText1;
    double formPadding = 5.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency Converter"),
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: formPadding, top: formPadding),
              child: TextField(
                controller: amountController,
                style: textStyle,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "e.g. 17.85",
                  labelText: "Amount",
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Container(
              height: formPadding,
            ),
            Row(children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _calculate();
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
                    _reset();
                  },
                  child: const Text(
                    'Reset',
                    textScaleFactor: 1.5,
                  ),
                ),
              ),
            ]),
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

  void _reset() {
    amountController.text = '';
    setState(() {
      _fromamount = '';
      _toamount = '';
    });
  }

  void _calculate() {
    double amount = double.parse(amountController.text);
    double result = amount * _from.value / _to.value;

    setState(() {
      _fromamount = '${amount.toStringAsFixed(3)} ${_from.shortname} =';
      _toamount = '${result.toStringAsFixed(3)} ${_to.shortname}';
    });
  }
}
