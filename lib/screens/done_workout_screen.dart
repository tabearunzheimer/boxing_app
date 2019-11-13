import 'package:flutter/material.dart';

class DoneWorkoutScreen extends StatefulWidget {
  @override
  _DoneWorkoutScreenState createState() => _DoneWorkoutScreenState();
}

class _DoneWorkoutScreenState extends State<DoneWorkoutScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kickbox App",
        ),
        actions: <Widget>[
          IconButton(
            onPressed: moveToHomeScreen,
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
      ),
    );
  }

  void moveToHomeScreen() {
    print("Move to Home-Screen");
    Navigator.pushNamed(context, '/home');
  }
}
