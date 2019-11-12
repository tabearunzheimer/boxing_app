import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uebung02/helper/current_workout_information.dart';
import 'package:uebung02/screens/choose_workout_techniques.dart';
import 'package:uebung02/screens/reusable_widgets.dart';

class ChooseWorkoutStyleScreen extends StatefulWidget {
  @override
  _ChooseWorkoutStyleScreenState createState() =>
      new _ChooseWorkoutStyleScreenState();
}

class _ChooseWorkoutStyleScreenState extends State<ChooseWorkoutStyleScreen>
    with SingleTickerProviderStateMixin {
  List<Tab> l = [
    Tab(
      child: Text("Runden"),
    ),
    Tab(
      child: Text("Reaktion"),
    ),
    Tab(
      child: Text("Offen"),
    )
  ];
  TabController _tabController;
  TextEditingController breakTextController;
  TextEditingController roundTextController;
  TextEditingController timePerRoundTextController;
  bool breakBetweenRounds = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: l.length);
    breakTextController = new TextEditingController();
    roundTextController = new TextEditingController();
    timePerRoundTextController = new TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    breakTextController.dispose();
    roundTextController.dispose();
    timePerRoundTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "Kickbox App",
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: l,
        ),
      ),
      body: TabBarView(controller: _tabController, children: <Widget>[
        buildRundenAndReaktionElement('assets/img/man_boxer.jpg', 0),
        buildRundenAndReaktionElement('assets/img/hill_fighter_meditate.jpg', 1),
        buildOffenElement('assets/img/man_boxer.jpg'),
      ]),
    );
  }

  Widget buildRundenAndReaktionElement(String imgPfad, int i) {
    String type;
    if (i == 0){
      type = "Runden";
    } else {
      type = "Reaktion";
    }

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(imgPfad),
            Card(
              margin: EdgeInsets.all(10),
              color: Color.fromRGBO(0, 0, 0, 0.1),
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
                  style: Theme.of(context).textTheme.body2,
                ),
              ),
            ),
            Container(
              child: Card(
                margin: EdgeInsets.all(10),
                color: Color.fromRGBO(0, 0, 0, 0.1),
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Pausen zwischen Runden: ",
                            style: Theme.of(context).textTheme.body2,
                          ),
                          Switch(
                            value: breakBetweenRounds,
                            onChanged: (value) {
                              setState(() {
                                breakBetweenRounds = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Dauer: ",
                            style: Theme.of(context).textTheme.body2,
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            child: TextField(
                              enabled: breakBetweenRounds,
                              controller: breakTextController,
                              decoration: new InputDecoration(),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: false, signed: true),
                            ),
                          ),
                          Text(
                            "sek",
                            style: Theme.of(context).textTheme.body2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 100,
              child: Card(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                "Anzahl der Runden: ",
                                style: Theme.of(context).textTheme.body2,
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                child: TextField(
                                  controller: roundTextController,
                                  decoration: new InputDecoration(),
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: false, signed: true),
                                ),
                              ),
                              //Text("0-99"),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "Dauer pro Runde: ",
                                style: Theme.of(context).textTheme.body2,
                              ),
                              //Text("min"),
                              Container(
                                width: 50,
                                height: 40,
                                child: TextField(
                                  controller: timePerRoundTextController,
                                  decoration: new InputDecoration(),
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: false, signed: true),
                                ),
                              ),
                              Text(
                                "sek",
                                style: Theme.of(context).textTheme.body2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    RawMaterialButton(
                      elevation: 10,
                      shape: CircleBorder(),
                      fillColor: Color.fromRGBO(255, 255, 255, 1),
                      child: Icon(Icons.arrow_forward),
                      onPressed: (){ showChooseWorkoutTechniquesScreenFromRound(type);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOffenElement(String imgPfad) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(imgPfad),
            Card(
              margin: EdgeInsets.all(10),
              color: Color.fromRGBO(0, 0, 0, 0.1),
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
                  style: Theme.of(context).textTheme.body2,
                ),
              ),
            ),
            Container(
              height: 100,
              child: Card(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Dauer (in Minuten): ",
                            style: Theme.of(context).textTheme.body2,
                          ),
                          //Text("min"),
                          Container(
                            width: 50,
                            height: 40,
                            child: TextField(
                              controller: timePerRoundTextController,
                              decoration: new InputDecoration(),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: false, signed: true),
                            ),
                          ),
                        ],
                      ),
                    ),
                    RawMaterialButton(
                      elevation: 10,
                      shape: CircleBorder(),
                      fillColor: Color.fromRGBO(255, 255, 255, 1),
                      child: Icon(Icons.arrow_forward),
                      onPressed: showChooseWorkoutTechniquesScreenFromOffen,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showChooseWorkoutTechniquesScreenFromOffen() {
    print("Change to choose-Workout-Techniques-Screen");
    int timePerRound = 0;
    try {
      timePerRound = int.parse(timePerRoundTextController.text);
      CurrentWorkoutInformation c = new CurrentWorkoutInformation(0, 0, timePerRound, "Offen");
      Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseWorkoutTechniques(c)),
      );

    } catch (e) {
      print(e);
    }
  }

  void showChooseWorkoutTechniquesScreenFromRound(String type) {
    print("Change to choose-Workout-Techniques-Screen");
    int timePerRound = 0;
    int breakTime = 0;
    int roundTimes = 0;

    try {
      timePerRound = int.parse(timePerRoundTextController.text);
      if (this.breakBetweenRounds){
        breakTime = int.parse(breakTextController.text);
      }
      roundTimes = int.parse(roundTextController.text);
      CurrentWorkoutInformation c = new CurrentWorkoutInformation(breakTime, roundTimes, timePerRound, type);
      Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => ChooseWorkoutTechniques(c)),
      );
    } catch (e) {
      print(e);
    }
  }
}
