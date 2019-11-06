import 'package:flutter/material.dart';
import 'package:uebung02/screens/reusable_widgets.dart';

class DiaryScreen extends StatefulWidget {
  @override
  _DiaryScreenState createState() => new _DiaryScreenState();
}

int selectedIndex = 1;
ReusableWidgets _reusableWidgets;

class _DiaryScreenState extends State<DiaryScreen> {
  @override
  Widget build(BuildContext context) {
    _reusableWidgets = new ReusableWidgets(context, selectedIndex);
    return new Scaffold(
      appBar: _reusableWidgets.getAppBar(),
      body: Center(
        child: Text("Start your workout"),
      ),
      bottomNavigationBar: _reusableWidgets.getBottomNavigataionBar(),
    );
  }

}
