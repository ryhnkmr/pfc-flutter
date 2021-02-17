import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pfc_flutter/models/user.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:pfc_flutter/conponents/value_meter.dart';

class Home extends StatefulWidget {
  static const id = 'home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final user = Provider.of<UserModel>(context,listen: false);
      user.getRecordDateTotalValue();
    });
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 6,
                    child: Center(
                      child: Consumer<UserModel>(
                        builder: (context, user, _) {
                          return Text(
                            '${DateFormat('yyyy-MM-dd').format(user.currentDate)}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                      child: Consumer<UserModel>(
                        builder: (context, user, _) {
                          return  IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () async {
                              final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: user.currentDate,
                                firstDate: DateTime(2015),
                                lastDate: DateTime(2050),
                              );
                              user.setSelectedDate(selectedDate);
                              user.getRecordDateTotalValue();
                            },
                          );
                        },
                      ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SfCircularChart(
                series: <CircularSeries>[
                  // Renders radial bar chart
                  RadialBarSeries<ChartData, String>(
                      maximumValue: 100,
                      dataSource: <ChartData>[
                            ChartData("protain", user.totalPro / user.aimPro * 100),
                            ChartData("fat", user.totalFat / user.aimFat * 100),
                            ChartData("Carbohydrogen", user.totalCar / user.aimCar * 100),
                        ],
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                  ),
                ],
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Consumer<UserModel>(
                      builder: (context, user, _){
                        return ValueMeter(todayTotalValue: user.totalPro, labelText: 'タンパク質', unitAndValue: '/${user.aimPro}g');
                      }
                  ),
                  Consumer<UserModel>(
                      builder: (context, user, _){
                        return ValueMeter(todayTotalValue: user.totalFat, labelText: '脂質', unitAndValue: '/${user.aimFat}g');
                      }
                  ),
                  Consumer<UserModel>(
                      builder: (context, user, _){
                        return ValueMeter(todayTotalValue: user.totalCar, labelText: '炭水化物', unitAndValue: '/${user.aimCar}g',);
                      }
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Consumer<UserModel>(
                      builder: (context, user, _){
                        return ValueMeter(todayTotalValue: user.aimCal, labelText: '目標', unitAndValue: 'kcal');
                      }
                  ),
                  Consumer<UserModel>(
                      builder: (context, user, _){
                        return ValueMeter(todayTotalValue: user.totalCal, labelText: '現在', unitAndValue: 'kcal');
                      }
                  ),
                  Consumer<UserModel>(
                      builder: (context, user, _){
                        return ValueMeter(todayTotalValue: user.aimCal - user.totalCal, labelText: 'あと', unitAndValue: 'kcal');
                      }
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
    );
  }
}



Widget _foodRecordItem(String title) {
  return Text(title);
}

class ChartData {
  ChartData(this.x, this.y, [this.text]);
  final String x;
  final num y;
  final String text;
}
