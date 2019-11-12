import 'package:flutter/material.dart';
import 'package:uebung02/screens/reusable_widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

int selectedIndex = 0;
ReusableWidgets _reusableWidgets;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    _reusableWidgets = new ReusableWidgets(context, selectedIndex);
    return Scaffold(
      appBar: _reusableWidgets.getAppBar(),
      body: Stack(
        children: <Widget>[
          buildBackgroundImage(),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Beginne dein Training",
                    style: TextStyle(
                      fontSize: 40.0,
                    ),
                  ),
                  Container(
                    height: 100.0,
                    width: 100.0,
                    child: RawMaterialButton(
                      shape: CircleBorder(),
                      fillColor: Color.fromRGBO(255, 255, 255, 1),
                      child: Text(
                        "Start",
                        style: Theme.of(context).textTheme.body2,
                      ),
                      onPressed: startChooseWorkout,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(55, 0, 55, 0),
                    child: Text(
                      "Versuche regelmäßig zu trainieren um einen optimalen Trainingserfolg zu erzielen.",
                      style: Theme.of(context).textTheme.display1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]),
          ),
        ],
      ),
      bottomNavigationBar: _reusableWidgets.getBottomNavigataionBar(),
    );
  }

  Widget buildBackgroundImage(){
    if (MediaQuery.of(context).size.width > MediaQuery.of(context).size.height){
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: new Image.asset(
          'assets/img/female_boxer.jpg',
          fit: BoxFit.fitHeight,
          //height: 900.0,
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: new Image.asset(
          'assets/img/female_boxer.jpg',
          fit: BoxFit.fitWidth,
          //height: 900.0,
        ),
      );
    }
  }

  void startChooseWorkout() {
    print("Change to Choose-Workout-Style-Screen");
    Navigator.pushNamed(context, '/chooseWorkoutStyle');
  }
}
