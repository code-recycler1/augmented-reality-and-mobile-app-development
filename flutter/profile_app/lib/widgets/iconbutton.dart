import 'package:flutter/material.dart';

typedef MyCallback = void Function(String text);

class IconButtonWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final MyCallback onButtonPressed;

  const IconButtonWidget(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon),
          const SizedBox(
            width: 5,
          ),
          Text(text.toUpperCase())
        ],
      ),
      onPressed: () {
        onButtonPressed(text);
      },
    );
  }
}
