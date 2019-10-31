import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kickbox App", style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.7),),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: (){
              print("Test");
            },
            color: Color.fromRGBO(0, 0, 0, 0.7),
          ),
        ],
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      body: Center(
        //child: Text("Start your workout"),
        child: Text("Haha"),

        /*Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/female_boxer.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Text("Start your workout"),
        ),
        */
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_pizza),
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

      ),
    );
  }
}