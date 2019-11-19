import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uebung02/helper/techniques_database_helper.dart';

import 'first_launch_one_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  final dbHelper = TechniquesDatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 200), () {
      checkFirstSeen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text('Loading...'),
      ),
    );
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      prefs.setBool('seen', true);
      dbHelper.insertList();
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => FirstLaunchScreenOne()));
    }
  }

}

