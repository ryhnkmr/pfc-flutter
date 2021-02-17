import 'package:flutter/material.dart';
import 'package:pfc_flutter/models/user.dart';
import 'package:provider/provider.dart';
import 'package:pfc_flutter/conponents/input_text_with_label.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class FavoriteRecord extends StatefulWidget {
  @override
  _FavoriteRecordState createState() => _FavoriteRecordState();
}

class _FavoriteRecordState extends State<FavoriteRecord> {
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
                  onPressed: () {
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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    print(user.favoriteFoodList[2]['name']);
    return SafeArea(
      child: ListView(
        children: [
          InputTextWithLabel(
            labelText: '検索', keyBoardType: TextInputType.text,
            onChange: (text) {
              user.searchFavoriteFood(text);
            }
          ),
          ListView.builder(
            physics: new ClampingScrollPhysics(),
            padding: const EdgeInsets.all(8),
            scrollDirection: Axis.vertical,
            primary: true,
            shrinkWrap: true,
            itemCount: user.favoriteFoodList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                child: Consumer<UserModel>(
                  builder: (context, user, _) {
                    return GestureDetector(
                      onTap: () {
                        _dialog(user.favoriteFoodList[index], user);
                      },
                      child: Column(
                        children: [
                          Text(
                            '${user.favoriteFoodList[index]['name']}',
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Calorie:${user.favoriteFoodList[index]['calorie']}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                'P:${user.favoriteFoodList[index]['protain']}g',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                'F:${user.favoriteFoodList[index]['fat']}g',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                'C:${user.favoriteFoodList[index]['carbo']}g',
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
              );
            }
          ),
        ],
      ),
    );
  }
}
