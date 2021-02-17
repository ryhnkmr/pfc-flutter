import 'package:flutter/material.dart';
import 'package:pfc_flutter/views/direct_input_record.dart' as DirectInputRecordWidget;
import 'package:pfc_flutter/views/favorite_record.dart' as FavoriteRecordWidget;
import 'package:pfc_flutter/views/search_record.dart' as SearchRecordWidget;

class Record extends StatefulWidget {
  static String id = 'record_screen';

  @override
  _RecordState createState() => _RecordState();
}

class _RecordState extends State<Record> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(icon: Icon(Icons.search)),
                Tab(icon: Icon(Icons.edit)),
                Tab(icon: Icon(Icons.grade)),
              ],
              labelColor: Colors.blue,
              indicatorColor: Colors.blue,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            Expanded(
                child: TabBarView(
                  children: [
                    SearchRecordWidget.SearchRecord(),
                    DirectInputRecordWidget.DirectInputRecord(),
                    FavoriteRecordWidget.FavoriteRecord(),
                  ],
                ),
            ),
          ],
        ),
    );
  }
}

class TabPage extends StatelessWidget {

  final IconData icon;
  final String title;

  const TabPage({Key key, this.icon, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Center(
      child:Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 64.0, color: textStyle.color),
          Text(title, style: textStyle),
        ],
      ),
    );
  }
}