import 'package:flutter/material.dart';
import 'package:uebung02/helper/current_workout_information.dart';

class DoneWorkoutScreen extends StatefulWidget {
  CurrentWorkoutInformation workoutInformation;

  DoneWorkoutScreen(CurrentWorkoutInformation cOld) {
    this.workoutInformation = cOld;
  }
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
        child: Stack(
          children: <Widget>[
            Container(
              ///Hintergrundbild
              child: new Image.asset(
                'assets/img/female_boxer.jpg',
                fit: BoxFit.fill,
                height: 900.0,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height / 2.5),
              margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height / 5)),
              //color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Gut gemacht", style: Theme.of(context).textTheme.headline,),
                  Divider(
                    color: Colors.white,
                    indent: 120,
                    endIndent: 120,
                    thickness: 2,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 80, right: 80),
                    child: Text("Nimm dir nach jedem Workout etwas Zeit um dich zu dehnen", textAlign: TextAlign.center,),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              margin: EdgeInsets.fromLTRB(0, (MediaQuery.of(context).size.height - 200), 0, 0),
              //color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width/3.5,
                    child: Text("kcal\n${widget.workoutInformation.kcal.roundToDouble()}",textAlign: TextAlign.center,),
                  ),
                  VerticalDivider(
                    indent: 20,
                    endIndent: 20,
                    color: Colors.white,
                    thickness: 2,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/3.5,
                    child:  Text("Rundenzeit\n${widget.workoutInformation.getRoundLengthMin()}:${widget.workoutInformation.getRoundLengthSec()}",textAlign: TextAlign.center,),
                  ),
                  VerticalDivider(
                    indent: 20,
                    endIndent: 20,
                    color: Colors.white,
                    thickness: 2,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/3.5,
                    child: Text("Bewertung\n ${widget.workoutInformation.rating}",textAlign: TextAlign.center,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void moveToHomeScreen() {
    print("Move to Home-Screen");
    Navigator.pushNamed(context, '/home');
  }
}
