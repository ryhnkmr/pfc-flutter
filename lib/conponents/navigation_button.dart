import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  NavigationButton({this.iconData, this.text, this.onPressed});

  IconData iconData;
  String text;
  Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          FlatButton(
            onPressed: onPressed,
            child: Icon(iconData),
          ),
          Text(text)
        ],
      ),
    );
  }
}
