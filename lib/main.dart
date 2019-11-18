import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uebung02/screens/choose_workout_style_screen.dart';
import 'package:uebung02/screens/choose_workout_summary_screen.dart';
import 'package:uebung02/screens/choose_workout_techniques.dart';
import 'package:uebung02/screens/diary_screen.dart';
import 'package:uebung02/screens/done_workout_screen.dart';
import 'package:uebung02/screens/first_launch_one_screen.dart';
import 'package:uebung02/screens/home_screen.dart';
import 'package:uebung02/screens/me_screen.dart';
import 'package:uebung02/screens/rate_workout_screen.dart';
import 'package:uebung02/screens/technique_details_screen.dart';
import 'package:uebung02/screens/workout_screen.dart';

import 'helper/techniques_database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  SharedPreferences prefs;
  bool firstLaunch;
  String launchkey = 'firstLaunKey';


  @override
  Widget build(BuildContext context) {

    final dbHelper = TechniquesDatabaseHelper.instance;

      SharedPreferences.getInstance().then((sp) {
      this.prefs = sp;
      loadBool(launchkey);
      if (this.firstLaunch){
        dbHelper.insertList();
        setBool(launchkey, false);
        try {
          dbHelper.insertList();
        } catch (e) {
          print("Fehler: $e");
          setBool(launchkey, true);
        }
      }
    });
     //TODO: Bei first launch starte mit firstlaunchscreen, sonst homescreen



    return MaterialApp(
      title: 'Basis App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: AppBarTheme(
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.8),
        accentColor: Color.fromRGBO(200, 0, 0, 1),
        cursorColor: Color.fromRGBO(200, 0, 0, 1),
        //buttonColor: Color.fromRGBO(0, 0, 0, 1),
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.white, fontFamily: 'Staatliches', fontSize: 20.0),
          body2: TextStyle(color: Colors.black, fontSize: 17.0),  //Theme.of(context).textTheme.body2
          display1: TextStyle(color: Colors.white, fontSize: 18.0),
          display2: TextStyle(color: Colors.black, fontFamily: 'Staatliches', fontSize: 17.0),
          display3: TextStyle(color: Colors.grey, fontSize: 12.0),
          display4: TextStyle(color: Colors.black, fontFamily: 'Staatliches', fontSize: 30.0),
          headline: TextStyle(color: Colors.white, fontFamily: 'Staatliches', fontSize: 60.0),
          subtitle: TextStyle(color: Colors.white, fontFamily: 'Staatliches', fontSize: 40.0),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/home' : (context) => HomeScreen(),
        '/diary' : (context) => DiaryScreen(),
        '/me' : (context) => MeScreen(),
        '/chooseWorkoutStyle' : (context) => ChooseWorkoutStyleScreen(),
        //'/TechniqueDetailsScreen' : (context) => TechniqueDetailsScreen(),
        '/RateWorkoutScreen' : (context) => RateWorkoutScreen(),
        '/DoneWorkoutScreen' : (context) => DoneWorkoutScreen(),
      },
      home: FirstLaunchScreenOne(),
    );
  }

  Future<Null> setBool(String key, bool b) async {
    await this.prefs.setBool(key, b);
    print("Bool saved");
  }

  void loadBool(String key) async {
      print("Get data");
      this.firstLaunch = prefs.get(key) ?? true;
  }
}
