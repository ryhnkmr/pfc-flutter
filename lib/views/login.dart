import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pfc_flutter/conponents/screen_argument.dart';
import 'package:pfc_flutter/models/user.dart';
import 'package:pfc_flutter/views/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

final _firesotre = FirebaseFirestore.instance;

class LoginScreen extends StatefulWidget {
  static const id = "login_sreen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User loggedInUser;
  User user;

  Future<User> _handleSignIn() async {
    GoogleSignInAccount googleCurrentUser = _googleSignIn.currentUser;
    try {
      if (googleCurrentUser == null) googleCurrentUser = await _googleSignIn.signInSilently();
      if (googleCurrentUser == null) googleCurrentUser = await _googleSignIn.signIn();
      if (googleCurrentUser == null) return null;

      GoogleSignInAuthentication googleAuth = await googleCurrentUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final User user = (await _auth.signInWithCredential(credential)).user;

      final userModel = Provider.of<UserModel>(context, listen: false);
      await userModel.userLogin(user);
      await userModel.fetchFoodRecordList();

      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/logo.png', width: 200, height: 200,),
              Text(
                'Simple PFC',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GoogleSignInButton(
                onPressed: () async {
                  try {
                    user = await _handleSignIn();
                    // ユーザーのデータがなければ作成する
                    var checkUser = await _firesotre.collection('users').doc('${user.uid}').get();

                    if (user != null) {
                      Navigator.pushNamed(context, '/main_page');
                    }
                  } catch(e) {
                    print(e);
                  }
                },
                // onPressed: () async {
                //     user = await _handleSignIn();
                //
                //     Navigator.pushNamed(context, '/main_page');
                //   },
              )
            ],
          ),
        ),
      ),
    );;
  }
}
