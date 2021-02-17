import 'package:flutter/material.dart';
import 'package:pfc_flutter/conponents/input_text_with_label.dart';
import 'package:provider/provider.dart';
import 'package:pfc_flutter/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

const baseURL = 'http://localhost:8000/api';

class SearchRecord extends StatefulWidget {
  @override
  _SearchRecordState createState() => _SearchRecordState();
}

class _SearchRecordState extends State<SearchRecord> {
  List records = [];
  DateTime _date = null;
  final format = DateFormat("yyyy-MM-dd");

  Future<void> _dialog(record, user) async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: const Text('お気に入り入力'),
              children: [
                Center(
                    child: Text('${record['name']}')
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Calorie:${record['calorie']}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'P:${record['protain']}g',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'F:${record['fat']}g',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'C:${record['carbo']}g',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DateTimeField(
                    format: format,
                    onChanged: (value) {
                      setState(() {
                        _date = value;
                      });
                      print(value);
                    },
                    onShowPicker: (context, currentValue) {
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: const Text('記録', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () async {
                      user.storeFoodRecord(record['calorie'], record['protain'], record['fat'], record['carbo'], record['name'], false, _date, 100);
                    },
                  ),
                ),
              ]
          );
        }
    )) {

    }
  }

  ScrollController _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return SafeArea(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '検索',
              ),
              keyboardType: TextInputType.text,
              onSubmitted: (text) async {
                final response = await http.get(baseURL + '/food_list?text=$text', headers: {"Accept": "application/json"});
                if (response.statusCode == 200) {
                  final data = jsonDecode(response.body);
                  print(data['message']);
                  print(data['result']);
                  setState(() {
                    records = data['result'];
                  });
                } else {
                  print('Request failed with status: ${response.statusCode}.');
                }
              },
            ),
          ),
          ListView.builder(
              physics: new ClampingScrollPhysics(),
              padding: const EdgeInsets.all(8),
              controller: _controller,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: records.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Container(
                      height: 50,
                      child: Consumer<UserModel>(
                        builder: (context, user, _) {
                          return GestureDetector(
                            onTap: () {
                              _dialog(records[index], user);
                            },
                            child: Column(
                              children: [
                                Text(
                                  '${records[index]['name']}',
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Calorie:${records[index]['calorie']}kcal',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      'P:${records[index]['protain']}g',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      'F:${records[index]['fat']}g',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      'C:${records[index]['carbo']}g',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
          ),
        ],
      ),
    );
  }
}
