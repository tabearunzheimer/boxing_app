import 'package:flutter/material.dart';

class MeScreen extends StatefulWidget {
  @override
  _MeScreenState createState() => new _MeScreenState();
}

int selectedIndex;

class _MeScreenState extends State<MeScreen> {
  @override
  Widget build(BuildContext context) {
    selectedIndex = 2;
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
      Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image(
            width: MediaQuery.of(context).size.width,
            image: AssetImage("assets/img/female_fighter_punch.jpg"),
            fit: BoxFit.fitWidth,
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Name",style: TextStyle(fontSize: 20.0),),
                  Text("User"),
                ],
              ),
              color: Color.fromRGBO(255, 255, 255, 1.0),
            ),

          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Persönliche Daten"),
                  Container(
                    //padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            width: 120.0,
                            alignment: Alignment.center,
                            child: Text("Geschlecht"),
                          ),
                          color: Color.fromRGBO(255, 255, 255, 0.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),semanticContainer: true,
                        ),
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            width: 120.0,
                            alignment: Alignment.center,
                            child: Text("Alter"),
                          ),
                          color: Color.fromRGBO(255, 255, 255, 0.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),semanticContainer: true,
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            width: 120.0,
                            alignment: Alignment.center,
                            child: Text("Größe"),
                          ),
                          color: Color.fromRGBO(255, 255, 255, 0.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),semanticContainer: true,
                        ),
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            width: 120.0,
                            alignment: Alignment.center,
                            child: Text("Gewicht"),
                          ),
                          color: Color.fromRGBO(255, 255, 255, 0.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),semanticContainer: true,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              color: Color.fromRGBO(255, 255, 255, 1.0),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            flex: 2,
            child: Container(
              //child: Text("Platzhalter"),
              color: Color.fromRGBO(255, 255, 255, 1.0),
            ),
          ),
        ],
      ),
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.9),
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
          print("Change to Diary Screen");
          Navigator.pop(context);
          Navigator.pushNamed(context, '/diary');
          break;
        case 2:
          print("Aktueller Screen");
          break;
      }
    });
  }
}
