import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pfc_flutter/conponents/input_text_with_label.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:pfc_flutter/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class DirectInputRecord extends StatefulWidget {
  static String id = 'record_screen';

  @override
  _DirectInputRecordState createState() => _DirectInputRecordState();
}

class _DirectInputRecordState extends State<DirectInputRecord> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _food = null;
  int _calorie = 0;
  DateTime _date = null;
  int _quantity = 0;
  int _protain = 0;
  int _fat = 0;
  int _carbon = 0;
  bool favoriteFlg = false;

  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InputTextWithLabel(
                  labelText: '食事名を入力',
                  keyBoardType: TextInputType.text,
                  onChange: (value) {
                    setState(() {
                      _food = value;
                    });
                  },
                ),
                InputTextWithLabel(
                  labelText: 'カロリーを入力(kcal)',
                  keyBoardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                  onChange: (value) {
                    print(_calorie);
                    setState(() {
                      _calorie = int.parse(value);
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    child: DateTimeField(
                      format: format,
                      onChanged: (value) {
                        setState(() {
                          _date = value;
                        });
                        print(value);
                      },
                      onShowPicker: (context, currentValue) {
                        print(currentValue);
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '日時を入力'
                      ),
                    ),
                  ),
                ),
                InputTextWithLabel(
                  labelText: '分量を入力(g)',
                  keyBoardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                  onChange: (value) {
                    setState(() {
                      _quantity = int.parse(value);
                    });
                  },
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text('P:タンパク質', style: TextStyle(fontSize: 10),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('$_protain', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                                Text('g'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Row(
                          children: [
                            RawMaterialButton(
                              onPressed: () {
                                setState(() {
                                  _protain--;
                                });
                              },
                              child: Icon(Icons.remove, color: Colors.white,),
                              constraints: BoxConstraints.tightFor(
                                width: 28,
                                height: 28,
                              ),
                              shape: CircleBorder(),
                              fillColor: Colors.blueAccent,
                            ),
                            Slider(
                              value: _protain.toDouble(),
                              min: 0,
                              max: 100,
                              divisions: 100,
                              label: _protain.round().toString(),
                              onChanged: (double value) {
                                setState(() {
                                  _protain = value.toInt();
                                });
                              },
                            ),
                            RawMaterialButton(
                              onPressed: () {
                                setState(() {
                                  _protain++;
                                });
                              },
                              child: Icon(Icons.add, color: Colors.white,),
                              constraints: BoxConstraints.tightFor(
                                width: 28,
                                height: 28,
                              ),
                              shape: CircleBorder(),
                              fillColor: Colors.blueAccent,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text('F:脂質', style: TextStyle(fontSize: 10),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('$_fat', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                                Text('g'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Row(
                          children: [
                            RawMaterialButton(
                              onPressed: () {
                                setState(() {
                                  _fat--;
                                });
                              },
                              child: Icon(Icons.remove, color: Colors.white,),
                              constraints: BoxConstraints.tightFor(
                                width: 28,
                                height: 28,
                              ),
                              shape: CircleBorder(),
                              fillColor: Colors.blueAccent,
                            ),
                            Slider(
                              value: _fat.toDouble(),
                              min: 0,
                              max: 100,
                              divisions: 100,
                              label: _fat.round().toString(),
                              onChanged: (double value) {
                                setState(() {
                                  _fat = value.toInt();
                                });
                              },
                            ),
                            RawMaterialButton(
                              onPressed: () {
                                setState(() {
                                  _fat++;
                                });
                              },
                              child: Icon(Icons.add, color: Colors.white,),
                              constraints: BoxConstraints.tightFor(
                                width: 28,
                                height: 28,
                              ),
                              shape: CircleBorder(),
                              fillColor: Colors.blueAccent,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text('C:炭水化物', style: TextStyle(fontSize: 10),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('$_carbon', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                                Text('g'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Row(
                          children: [
                            RawMaterialButton(
                              onPressed: () {

                                setState(() {
                                  _carbon--;
                                });
                              },
                              child: Icon(Icons.remove, color: Colors.white,),
                              constraints: BoxConstraints.tightFor(
                                width: 28,
                                height: 28,
                              ),
                              shape: CircleBorder(),
                              fillColor: Colors.blueAccent,
                            ),
                            Slider(
                              value: _carbon.toDouble(),
                              min: 0,
                              max: 100,
                              divisions: 100,
                              label: _carbon.round().toString(),
                              onChanged: (double value) {
                                setState(() {
                                  _carbon = value.toInt();
                                });
                              },
                            ),
                            RawMaterialButton(
                              onPressed: () {
                                setState(() {
                                  _carbon++;
                                });
                              },
                              child: Icon(Icons.add, color: Colors.white,),
                              constraints: BoxConstraints.tightFor(
                                width: 28,
                                height: 28,
                              ),
                              shape: CircleBorder(),
                              fillColor: Colors.blueAccent,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: RawMaterialButton(
                          onPressed:(){
                            setState(() {
                              favoriteFlg = !favoriteFlg;
                            });
                          },
                        child: Icon(Icons.star, color: favoriteFlg ? Colors.yellow : Colors.grey,),
                        shape: CircleBorder(),
                        fillColor: Colors.blueAccent,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: RaisedButton(
                          child: const Text('記録', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () {
                            user.storeFoodRecord(_calorie, _protain, _fat, _carbon, _food, favoriteFlg, _date, _quantity);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}
