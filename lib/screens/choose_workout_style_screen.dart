import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uebung02/helper/current_workout_information.dart';
import 'package:uebung02/screens/choose_workout_techniques.dart';
import 'package:uebung02/screens/music_screen.dart';

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

  //TODO Add Text Controller
  TabController _tabController;
  bool breakBetweenRounds = false;
  String errorText = "";

  int breakminutes, breakseconds, roundamout, roundminutes, roundseconds;

  @override
  void initState() {
    _tabController = new TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
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
        buildRundenAndReaktionElement('assets/img/female_punchingbag.jpg', 1),
        buildOffenElement('assets/img/training_fight.jpg'),
      ]),
    );
  }

  Widget buildRundenAndReaktionElement(String imgPfad, int i) {
    String type = i == 0 ? "Runden" : "Reaktion";

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
              shape: new RoundedRectangleBorder(
                  side: new BorderSide(
                      color: Color.fromRGBO(200, 0, 0, 1), width: 2.0),
                  borderRadius: BorderRadius.circular(4.0)),
              margin: EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  i == 0
                      ? "Beim Runden-Training kannst du einen typischen Boxkampf simulieren oder einfach Sets mit Pausen festlegen um verschiedene Techniken zu trainieren. Für die klassische Runden-Simulation solltest du keine Techniken auswählen."
                      : "Das Reaktionstraining funktioniert wie das Runden-Training, allerdings musst du hier verschiedene Techniken auswählen. Diese werden dann während des Trainings genannt und du musst Sie so schnell wie möglich ausführen.",
                  style: Theme.of(context).textTheme.body2,
                ),
              ),
            ),
            Container(
              height: 150,
              child: Card(
                shape: new RoundedRectangleBorder(
                    side: new BorderSide(
                        color: Color.fromRGBO(200, 0, 0, 1), width: 2.0),
                    borderRadius: BorderRadius.circular(4.0)),
                margin: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Dauer: ",
                            style: Theme.of(context).textTheme.body2,
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            child: TextFormField(
                              enabled: breakBetweenRounds,
                              decoration: new InputDecoration(),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: false, signed: true),
                              onChanged: (String value) {
                                setState(() {
                                  this.breakminutes = int.parse(value);
                                });
                              },
                            ),
                          ),
                          Text(
                            "min",
                            style: Theme.of(context).textTheme.body2,
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            child: TextFormField(
                                enabled: breakBetweenRounds,
                                decoration: new InputDecoration(),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: false, signed: true),
                                onChanged: (String value) {
                                  setState(() {
                                    this.breakseconds = int.parse(value);
                                  });
                                }),
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
              height: 130,
              child: Card(
                shape: new RoundedRectangleBorder(
                    side: new BorderSide(
                        color: Color.fromRGBO(200, 0, 0, 1), width: 2.0),
                    borderRadius: BorderRadius.circular(4.0)),
                margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
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
                                child: TextFormField(
                                    decoration: new InputDecoration(),
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: false, signed: true),
                                    onChanged: (String value) {
                                      setState(() {
                                        this.roundamout = int.parse(value);
                                      });
                                    }),
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
                                width: 40,
                                height: 40,
                                child: TextFormField(
                                    decoration: new InputDecoration(),
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: false, signed: true),
                                    onChanged: (String value) {
                                      setState(() {
                                        this.roundminutes = int.parse(value);
                                      });
                                    }),
                              ),
                              Text(
                                "min",
                                style: Theme.of(context).textTheme.body2,
                              ),

                              Container(
                                width: 40,
                                height: 40,
                                child: TextFormField(
                                    decoration: new InputDecoration(),
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: false, signed: true),
                                    onChanged: (String value) {
                                      setState(() {
                                        this.roundseconds = int.parse(value);
                                      });
                                    }),
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
                      onPressed: () {
                        if (!this.breakBetweenRounds) {
                          this.breakseconds = 0;
                          this.breakminutes = 0;
                        }
                        if (validateAll()) {
                          type == "Reaktion"
                              ? showChooseWorkoutTechniquesScreen(type)
                              : showMusicScreen(type);
                        } else {
                          print("Fehler beim validieren");
                          Flushbar(
                            title: "Hinweis",
                            message: "$errorText",
                            backgroundColor: Colors.black54,
                            margin: EdgeInsets.all(10),
                            borderRadius: 10,
                            duration: Duration(seconds: 3),
                          )..show(context);
                        }
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

  bool validateMinutes(int min) {
    if (min == 0 && this.breakBetweenRounds) {
      errorText = "Der Minutenwert muss größer als 0 sein";
      return false;
    }
    return true;
  }

  bool validateSeconds(int sec) {
    print("Sekunden $sec");
    if (sec == 0 && this.breakBetweenRounds) {
      errorText = "Der Sekundenwert muss größer als 0 sein";
      return false;
    } else if (sec >= 60) {
      errorText = "Der Sekundenwert muss kleiner als 60 sein";
      return false;
    }
    return true;
  }

  bool validateRounds(int r) {
    if (r == 0) {
      errorText = "Der Rundenwert muss größer als 0 sein";
      return false;
    }
    return true;
  }

  Widget buildOffenElement(String imgPfad) {
    String type = "Offen";
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
              shape: new RoundedRectangleBorder(
                  side: new BorderSide(
                      color: Color.fromRGBO(200, 0, 0, 1), width: 2.0),
                  borderRadius: BorderRadius.circular(4.0)),
              margin: EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  "Beim Offenen Training gibt es keine Pausen, du kannst Sie dir aber selbst aussuchen indem du während des Trainings auf Pause drückst. Zusätzlich kannst du Musik auswählen die im Hintergrund läuft und dich motiviert. Hierbei kannst du keine Techniken auswählen.",
                  style: Theme.of(context).textTheme.body2,
                ),
              ),
            ),
            Container(
              height: 100,
              child: Card(
                shape: new RoundedRectangleBorder(
                    side: new BorderSide(
                        color: Color.fromRGBO(200, 0, 0, 1), width: 2.0),
                    borderRadius: BorderRadius.circular(4.0)),
                margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Dauer: ",
                            style: Theme.of(context).textTheme.body2,
                          ),
                          //Text("min"),
                          Container(
                            width: 40,
                            height: 40,
                            child: TextFormField(
                                decoration: new InputDecoration(),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: false, signed: true),
                                onChanged: (String value) {
                                  setState(() {
                                    this.roundminutes = int.parse(value);
                                  });
                                }),
                          ),
                          Text(
                            "min",
                            style: Theme.of(context).textTheme.body2,
                          ),

                          Container(
                            width: 40,
                            height: 40,
                            child: TextFormField(
                                decoration: new InputDecoration(),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: false, signed: true),
                                onChanged: (String value) {
                                  setState(() {
                                    this.roundseconds = int.parse(value);
                                  });
                                }),
                          ),
                          Text(
                            "sek",
                            style: Theme.of(context).textTheme.body2,
                          ),
                        ],
                      ),
                    ),
                    RawMaterialButton(
                      elevation: 10,
                      shape: CircleBorder(),
                      fillColor: Color.fromRGBO(255, 255, 255, 1),
                      child: Icon(Icons.arrow_forward),
                      onPressed: () {
                        setState(() {
                          this.breakBetweenRounds = false;
                          this.breakseconds = 0;
                          this.breakminutes = 0;
                          this.roundamout = 1;
                        });
                        if (validateAll()) {
                          showMusicScreen(type);
                        } else {
                          print("Fehler beim validieren");
                          Flushbar(
                            title: "Hinweis",
                            message: "$errorText",
                            backgroundColor: Colors.black54,
                            margin: EdgeInsets.all(10),
                            borderRadius: 10,
                            duration: Duration(seconds: 3),
                          )..show(context);
                        }
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

  void showMusicScreen(String type) {
    print("Change to Music-Screen");
    try {
      CurrentWorkoutInformation c = new CurrentWorkoutInformation(
          this.breakminutes,
          this.breakseconds,
          this.roundamout,
          this.roundminutes,
          this.roundseconds,
          type);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MusicScreen(c)),
      );
    } catch (e) {
      print(e);
    }
  }

  bool validateAll() {
    if (!validateMinutes(this.breakminutes)) return false;
    if (!validateSeconds(this.breakseconds)) return false;
    if (!validateRounds(this.roundamout)) return false;
    if (!validateMinutes(this.roundminutes)) return false;
    if (!validateSeconds(this.roundseconds)) return false;
    return true;
  }

  void showChooseWorkoutTechniquesScreen(String type) {
    print("Change to choose-Workout-Techniques-Screen");
    try {
      CurrentWorkoutInformation c = new CurrentWorkoutInformation(
          this.breakminutes,
          this.breakseconds,
          this.roundamout,
          this.roundminutes,
          this.roundseconds,
          type);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChooseWorkoutTechniques(c)),
      );
    } catch (e) {
      print(e);
    }
  }
}
