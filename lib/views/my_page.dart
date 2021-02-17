import 'package:flutter/material.dart';
import 'package:pfc_flutter/views/home.dart';
import 'package:pfc_flutter/views/setting.dart';
import 'package:pfc_flutter/views/record.dart';

int _currentIndex = 0;

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  final _pageWidgets = [
    Home(),
    Record(),
    Setting(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple PFC Management'),),
      body:  _pageWidgets.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.add), title: Text('Record')),
          BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text('Setting')),
        ],
        currentIndex: _currentIndex,
        fixedColor: Colors.blueAccent,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}


