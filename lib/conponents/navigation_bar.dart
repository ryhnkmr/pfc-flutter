import 'package:flutter/material.dart';
import 'package:pfc_flutter/conponents/navigation_button.dart';
import 'package:pfc_flutter/views/home.dart';
import 'package:pfc_flutter/views/setting.dart';
import 'package:pfc_flutter/views/record.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationButton(
          text: 'Home',
          iconData: Icons.home,
          onPressed: (){
            Navigator.pushNamed(context, Home.id);
          },
        ),
        NavigationButton(
          text: 'Record',
          iconData: Icons.add,
          onPressed: (){
            Navigator.pushNamed(context, Record.id);
          },
        ),
        NavigationButton(
          text: 'Setting',
          iconData: Icons.settings,
          onPressed: (){
            Navigator.pushNamed(context, Setting.id);
          },
        ),
      ],
    );
  }
}
