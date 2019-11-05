import 'package:flutter/material.dart';

class DiaryScreen extends StatefulWidget {
  @override
  _DiaryScreenState createState() => new _DiaryScreenState();
}

int selectedIndex;

class _DiaryScreenState extends State<DiaryScreen> {
  @override
  Widget build(BuildContext context) {
    selectedIndex = 1;
    return new Scaffold(
      appBar: AppBar(
        title: Text("Kickbox App", style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 0.8),
        )),
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      body: Center(
        child: Text("Start your workout"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            title: Text('Training'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: Text('Tagebuch'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Ich'),
          ),
        ],
        selectedItemColor: Color.fromRGBO(200, 0, 0, 1),
        currentIndex: selectedIndex,
        onTap: onTapNavigation,

      ),
    );
  }

  void onTapNavigation(int value) {
    setState( (){
      selectedIndex = value;
      switch(value){
        case 0:
          print("Back to home Screen");
          Navigator.pop(context);
          Navigator.pushNamed(context, '/home');
          break;
        case 1:
          print("Aktueller Screen");
          break;
        case 2:
          print("Nicht implementiert");
          break;
      }
    });
  }
}
