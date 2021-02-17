import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextWithLabel extends StatelessWidget {

  InputTextWithLabel({@required this.labelText, @required this.keyBoardType, @required this.onChange});

  final String labelText;
  final TextInputType keyBoardType;
  final Function onChange;
  // final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          // Expanded(
          //   child: Text(title),
          //   flex: 3,
          // ),
          Expanded(
            flex: 7,
            child: Container(
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: labelText,
                ),
                keyboardType: keyBoardType,
                onChanged: onChange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
