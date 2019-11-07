import 'package:flutter/material.dart';
import 'package:uebung02/screens/reusable_widgets.dart';

class MeScreen extends StatefulWidget {
  @override
  _MeScreenState createState() => new _MeScreenState();
}

int selectedIndex = 2;
ReusableWidgets _reusableWidgets;

class _MeScreenState extends State<MeScreen> {
  @override
  Widget build(BuildContext context) {
    _reusableWidgets = new ReusableWidgets(context, selectedIndex);
    return Scaffold(
      appBar: _reusableWidgets.getAppBar(),
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
                  Row(
                    children: <Widget>[
                      Text("Name",style: Theme.of(context).textTheme.body2,),
                      IconButton(
                        onPressed: null,
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                  Text("User", style: Theme.of(context).textTheme.body2,),
                ],
              ),
              color: Color.fromRGBO(255, 255, 255, 1.0),
            ),

          ),
          SizedBox(
            height: 5.0,
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
            height: 5.0,
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
      bottomNavigationBar: _reusableWidgets.getBottomNavigataionBar(),
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
