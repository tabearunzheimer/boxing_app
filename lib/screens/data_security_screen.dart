import 'package:flutter/material.dart';
import 'package:uebung02/screens/reusable_widgets.dart';

class DataSecurityScreen extends StatefulWidget {
  @override
  _DataSecurityScreenState createState() => _DataSecurityScreenState();
}

class _DataSecurityScreenState extends State<DataSecurityScreen> {
  @override
  Widget build(BuildContext context) {
    ReusableWidgets reusableWidgets = new ReusableWidgets(context, -1);
    return Scaffold(
      appBar: reusableWidgets.getSimpleAppBar(),
      body: Center(
        child: Text("Platzhalter", style: TextStyle(color: Colors.black),),
      ),
    );
  }
}
