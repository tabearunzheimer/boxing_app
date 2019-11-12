import 'package:flutter/material.dart';
import 'package:uebung02/screens/reusable_widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime currentBackPressTime;
  BuildContext ctx;
  int selectedIndex = 0;
  ReusableWidgets _reusableWidgets;

  @override
  Widget build(BuildContext context) {
    _reusableWidgets = new ReusableWidgets(context, selectedIndex);
    this.ctx = context;
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
          WillPopScope(
            onWillPop: backButtonOverride,
            child: Container(),
          )
        ],
      ),
      bottomNavigationBar: _reusableWidgets.getBottomNavigataionBar(),
    );
  }

  Widget buildBackgroundImage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: new Image.asset(
        'assets/img/female_boxer.jpg',
        fit: BoxFit.cover,
        //height: 900.0,
      ),
    );
  }

  void startChooseWorkout() {
    print("Change to Choose-Workout-Style-Screen");
    Navigator.pushNamed(context, '/chooseWorkoutStyle');
  }

  Future<bool> backButtonOverride() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      //Fluttertoast.showToast(msg: exit_warning);
      print("Show snackbar");
      final scaffold = Scaffold.of(ctx);
      //print(scaffold);
      final snackBar = SnackBar(content: Text('Press two times to exit'), backgroundColor: Colors.red, duration: Duration(seconds: 1),);
      //print(snackBar.content);
      //print("2 mal druecken fuer schliessen");
    return Future.value(true);
    //Fluttertoast.showToast(msg: "Press two times to exit",);
    scaffold.showSnackBar(snackBar);
    return Future.value(false);
  }
  }
}
