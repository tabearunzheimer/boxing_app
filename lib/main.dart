import 'package:flutter/material.dart';
import 'package:uebung02/screens/choose_workout_style_screen.dart';
import 'package:uebung02/screens/choose_workout_summary_screen.dart';
import 'package:uebung02/screens/choose_workout_techniques.dart';
import 'package:uebung02/screens/diary_screen.dart';
import 'package:uebung02/screens/home_screen.dart';
import 'package:uebung02/screens/me_screen.dart';
import 'package:uebung02/screens/technique_details_screen.dart';
import 'package:uebung02/screens/workout_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.white, fontFamily: 'Staatliches', fontSize: 20.0),
          body2: TextStyle(color: Colors.black, fontSize: 17.0),  //Theme.of(context).textTheme.body2
          display1: TextStyle(color: Colors.white, fontSize: 18.0),
          display2: TextStyle(color: Colors.black, fontFamily: 'Staatliches', fontSize: 17.0),
          display3: TextStyle(color: Colors.grey, fontSize: 12.0),
          display4: TextStyle(color: Colors.black, fontFamily: 'Staatliches', fontSize: 30.0),
          headline: TextStyle(color: Colors.white, fontFamily: 'Staatliches', fontSize: 60.0),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/home' : (context) => HomeScreen(),
        '/diary' : (context) => DiaryScreen(),
        '/me' : (context) => MeScreen(),
        '/chooseWorkoutStyle' : (context) => ChooseWorkoutStyleScreen(),
        '/chooseWorkoutTechniques' : (context) => ChooseWorkoutTechniques(),
        '/ChooseWorkoutSummaryScreen' : (context) => ChooseWorkoutSummaryScreen(),
        '/WorkoutScreen' : (context) => WorkoutScreen(),
        '/TechniqueDetailsScreen' : (context) => TechniqueDetailsScreen(),
      },
      home: HomeScreen(),
    );
  }
}
