import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pfc_flutter/models/user.dart';

class ValueMeter extends StatelessWidget {
  const ValueMeter({
    Key key,
    @required this.todayTotalValue,
    @required this.labelText,
    @required this.unitAndValue,
  }) : super(key: key);

  final int todayTotalValue;
  final String labelText;
  final String unitAndValue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text('$labelText'),
          Text(
            '$todayTotalValue',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
            ),),
          Text('$unitAndValue'),
        ],
      ),
    );
  }
}