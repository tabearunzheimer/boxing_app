import 'package:flutter/material.dart';
import 'package:uebung02/screens/diary_screen.dart';
import 'package:uebung02/screens/home_screen.dart';
import 'package:uebung02/screens/me_screen.dart';

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
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.white),
          body2: TextStyle(color: Colors.black),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/home' : (context) => HomeScreen(),
        '/diary' : (context) => DiaryScreen(),
        '/me' : (context) => MeScreen(),
      },
      home: HomeScreen(),
    );
  }
}
