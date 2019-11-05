import 'package:flutter/material.dart';
import 'package:uebung02/screens/diary_screen.dart';
import 'package:uebung02/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basis App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/home' : (context) => HomeScreen(),
        '/diary' : (context) => DiaryScreen(),
      },
      home: HomeScreen(),
    );
  }
}
