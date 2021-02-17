import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pfc_flutter/models/user.dart';
import 'package:pfc_flutter/views/login.dart';
import 'package:pfc_flutter/views/my_page.dart';
import 'package:pfc_flutter/views/home.dart';
import 'package:pfc_flutter/views/direct_input_record.dart';
import 'package:pfc_flutter/views/setting.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(
      ChangeNotifierProvider(
        create: (context) => UserModel(),
        child: MyApp(),
      ),
    );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyPage(),
      initialRoute: '/login',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/login': (context) => LoginScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/main_page': (context) => MyPage(),
      },
    );
  }
}

