import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


const data = [];

class FoodRecordList extends StatefulWidget {
  @override
  _FoodRecordListState createState() => _FoodRecordListState();
}

class _FoodRecordListState extends State<FoodRecordList> {
  final _firesotre = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User currentUser;
  DateTime recordDate;
  String foodName;

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          currentUser = user;
        });

        //その日のレコードを全部取得
        recordDate = new DateTime.now();
        recordDate = new DateTime(recordDate.year, recordDate.month, recordDate.day);
        _firesotre
            .collection('users').doc('${currentUser.uid}')
            .collection('records').where('record_date', isEqualTo: recordDate).get()
            .then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((doc) {
            setState(() {
              foodName = doc['foodName'];
              data.add(foodName);
            });
            print(data);
          })
        });
      }
    } catch(e) {
      print(e);
    };
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple PFC Management')),
      body: ListView(
        children: [],
      ),
    );
  }
}
