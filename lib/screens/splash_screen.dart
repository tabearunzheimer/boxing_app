import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uebung02/helper/techniques_database_helper.dart';
import 'package:uebung02/helper/workout_database_helper.dart';

import 'first_launch_one_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  final dbHelperTechniques = TechniquesDatabaseHelper.instance;
  final dbHelperWorkout = WorkoutDatabaseHelper.instance;

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

  ///checks if this is the first time the user uses the app
  ///loads first launch screen if it is the first time
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      prefs.setBool('seen', true);
      dbHelperTechniques.insertList();
      Map<String, dynamic> row = {};
      dbHelperWorkout.insert(row);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => FirstLaunchScreenOne()));
    }
  }

}

