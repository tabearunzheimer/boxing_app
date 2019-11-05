import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

int selectedIndex;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    selectedIndex = 0;
    return Scaffold(

      appBar: AppBar(
        title: Text(
          "Kickbox App", style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.7),),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              print("Test");
            },
            color: Color.fromRGBO(0, 0, 0, 0.7),
          ),
        ],
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      body:
      Stack(
        children: <Widget>[
          Center(
            child: new Image.asset('assets/img/female_boxer.jpg', fit: BoxFit.cover, height: 900.0,),
          ),
          Center(
            child: Text("Start your workout", style: TextStyle(fontSize: 20.0, color: Color.fromRGBO(255, 255, 255, 1),),),
          ),
        ],
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
            icon: Icon(Icons.person),
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
    setState((){
      selectedIndex = value;
      switch(value){
        case 0:
          print("Aktueller Screen");
          break;
        case 1:
          print("Change to Diary Screen");
          Navigator.pop(context);
          Navigator.pushNamed(context, '/diary');
          break;
        case 2:
          print("Nicht implementiert");
          break;
      }
    });
  }
}