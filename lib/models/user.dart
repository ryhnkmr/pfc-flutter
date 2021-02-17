import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class UserModel extends ChangeNotifier {
  static const baseURL = 'http://localhost:8000/api/user';
  // static const baseURL = 'https://pfc-api.herokuapp.com/api/user';
  int userId;
  String uid;
  String email;

  int aimCal = 0;
  int aimPro = 0;
  int aimFat = 0;
  int aimCar = 0;
  int totalCal = 0;
  int totalPro = 0;
  int totalFat = 0;
  int totalCar = 0;
  DateTime currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  List foodRecordList = [];
  List<dynamic> favoriteFoodList;
  List filteredFavoriteFoodList= [];


  @override
  //UserController@store
  //Memo:Login時にApiサーバーにアクセスしてユーザーがいたらそのデータを返し、データがなければ新規作成後にレコードを返す
  void userLogin(user) async {
    // Laravel Apiサーバーにアクセス
    var response = await http.post(baseURL,
        body: {'uid': user.uid, 'email': user.email, 'name': user.displayName, 'password': 'password' },
        headers: {"Accept": "application/json"}
    );

    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data['message']);
      setUserData(data);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  //UserController@update
  void updateUserData(aimCal, aimPro, aimFat, aimCar) async {
    final response = await http.put(baseURL + '/$userId',
        body: {'aim_cal': '$aimCal', 'aim_protain': '$aimPro', 'aim_fat': '$aimFat', 'aim_car': '$aimCar'},
        headers: {"Accept": "application/json"}
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data['message']);
      setUserData(data);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  //FoodRecordList@index
  void fetchFoodRecordList() async {
    final response = await http.get(baseURL + '/$userId/food_record_list', headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data['message']);
      foodRecordList = data['records'];
      favoriteFoodList = data['favorite_records'];
      notifyListeners();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  //FoodRecordList@store
  void storeFoodRecord(_calorie, _protain, _fat, _carbon, _food, favoriteFlg, _date, _quantity) async {
    final response = await http.post(
        baseURL + '/$userId/food_record_list',
        body: {
          'calorie': '$_calorie',
          'protain': '$_protain',
          'fat': '$_fat',
          'carbo': '$_carbon',
          'name': '$_food',
          'favorite_flg': '${favoriteFlg? 1 : 0}',
          'recorded_at': '${DateFormat('yyyy-MM-dd').format(_date)}',
          'quantity': '$_quantity',
        },
        headers: {"Accept": "application/json"}
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data['message']);
      foodRecordList.add(data['record']);
      notifyListeners();
      print(data);
      if (data['record']['favorite_flg'] == 1) {
        favoriteFoodList.add(data['record']);
        notifyListeners();
      }
      notifyListeners();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }


  //これより以下はhelper function
  void getRecordDateTotalValue() {
    // currentで表示されているデータを初期化
    totalCal = 0;
    totalPro = 0;
    totalFat = 0;
    totalCar = 0;

    foodRecordList.forEach((foodRecord) {
      print(foodRecord);
      if (foodRecord['recorded_at'] == DateFormat('yyyy-MM-dd').format(currentDate)) {
        totalCal += foodRecord['calorie'] is String ? int.parse(foodRecord['calorie']) : foodRecord['calorie'];
        totalPro += foodRecord['protain'] is String ? int.parse(foodRecord['protain']) : foodRecord['protain'];
        totalFat += foodRecord['fat'] is String ? int.parse(foodRecord['fat']) : foodRecord['fat'];
        totalCar += foodRecord['carbo'] is String ? int.parse(foodRecord['carbo']) : foodRecord['protain'];
      }
    });
    print(foodRecordList);
    notifyListeners();
  }



  // 3項演算子はApiの返り値がString型でエラーを吐いたので処理
  void setUserData(data) {
    userId = data['user']['id'];
    uid = data['user']['uid'];
    aimCal = data['user']['aim_cal'] is String ? int.parse(data['user']['aim_cal']): data['user']['aim_cal'];
    aimPro = data['user']['aim_protain'] is String ? int.parse(data['user']['aim_protain']): data['user']['aim_protain'] ;
    aimFat = data['user']['aim_fat'] is String ? int.parse(data['user']['aim_fat']): data['user']['aim_fat'];
    aimCar = data['user']['aim_car'] is String ? int.parse(data['user']['aim_car']) : data['user']['aim_car'];
    notifyListeners();
  }

  void setSelectedDate(date) {
    if (date != null) {
      currentDate = date;
      notifyListeners();
    }
  }

  List searchFavoriteFood(text) {
    filteredFavoriteFoodList = favoriteFoodList.where((food) => food['name'].contains('$text'));
  }

  List filterByDate(recordDate) {
    return foodRecordList.where((record) => record['recorded_at' ] == recordDate);
  }
}