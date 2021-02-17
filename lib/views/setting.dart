
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pfc_flutter/conponents/input_text_with_label.dart';
import 'package:pfc_flutter/conponents/navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pfc_flutter/models/user.dart';
import 'package:pfc_flutter/conponents/value_meter.dart';

final _firesotre = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class Setting extends StatefulWidget {
  static const id = 'setting_screen';

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  int _protain;
  int _fat;
  int _carbo;
  int _calorie;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('現在の摂取目標', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Consumer<UserModel>(
                        builder: (context, user, _) {
                          return ValueMeter(todayTotalValue: user.aimCal, labelText: '摂取カロリー', unitAndValue: 'kcal',);
                        }
                      ),
                      Consumer<UserModel>(
                          builder: (context, user, _) {
                            return ValueMeter(todayTotalValue: user.aimPro, labelText: 'タンパク質', unitAndValue: 'g',);
                          }
                      ),
                      Consumer<UserModel>(
                          builder: (context, user, _) {
                            return ValueMeter(todayTotalValue: user.aimFat, labelText: '脂質', unitAndValue: 'g',);
                          }
                      ),
                      Consumer<UserModel>(
                          builder: (context, user, _) {
                            return ValueMeter(todayTotalValue: user.aimCar, labelText: '炭水化物', unitAndValue: 'g',);
                          }
                      ),
                    ],
                  ),
                ),
                InputTextWithLabel(
                  labelText: '1日の摂取カロリー目標を入力(kcal)',
                  keyBoardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                  onChange: (value) {
                    _calorie = int.parse(value);
                  },
                ),
                InputTextWithLabel(
                  labelText: 'タンパク質摂取目標を入力(g)',
                  keyBoardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                  onChange: (value) {
                    _protain = int.parse(value);
                  },
                ),
                InputTextWithLabel(
                  labelText: '脂質摂取目標を入力(g)',
                  keyBoardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                  onChange: (value) {
                    _fat = int.parse(value);
                    },
                ),
                InputTextWithLabel(
                  labelText: '炭水化物摂取目標を入力(g)',
                  keyBoardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                  onChange: (value) {
                    _carbo = int.parse(value);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: RaisedButton(
                    child: const Text('記録', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      // recordData();
                      user.updateUserData(_calorie, _protain, _fat, _carbo);
                    },
                  ),
                ),
                SizedBox(height: 100,),
              ],
            ),
          ),
        ),
      );
  }
}
