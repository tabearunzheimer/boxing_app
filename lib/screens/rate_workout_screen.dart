import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uebung02/helper/CustomRateWorkoutPainter.dart';
import 'package:uebung02/helper/current_workout_information.dart';
import 'package:uebung02/helper/workout_database_helper.dart';
import 'package:uebung02/screens/done_workout_screen.dart';

class RateWorkoutScreen extends StatefulWidget {
  CurrentWorkoutInformation workoutInformation;

  RateWorkoutScreen(CurrentWorkoutInformation cOld) {
    this.workoutInformation = cOld;
  }

  @override
  _RateWorkoutScreenState createState() => _RateWorkoutScreenState();
}

class _RateWorkoutScreenState extends State<RateWorkoutScreen>
    with TickerProviderStateMixin {
  SharedPreferences prefs;
  double weight;
  AnimationController controller;
  bool tapInProgress;
  int rating = 0;
  double posx = 100.0;
  double posy = 100.0;
  static const String userWeightKey = 'userWeight';

  final dbHelperWorkouts = WorkoutDatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sp) {
      this.prefs = sp;
      loadDouble(userWeightKey);
    });
    this.controller = AnimationController(
      vsync: this,
    );
    this.tapInProgress = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kickbox App",
        ),
        actions: <Widget>[
          IconButton(
            onPressed: moveToDoneWorkoutScreen,
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: Stack(
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
            margin:
            EdgeInsets.only(top: (MediaQuery
                .of(context)
                .size
                .height) / 5),
            height: (MediaQuery
                .of(context)
                .size
                .height / 7),
            width: (MediaQuery
                .of(context)
                .size
                .width),
            //color: Colors.green,
            alignment: Alignment.center,
            child: AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, Widget child) {
                  return Text(
                    getCurrentRating(context),
                    style: TextStyle(fontSize: 112.0, color: Colors.white),
                  );
                }),
          ),
          Container(),
          Container(
            margin: EdgeInsets.only(
                top: (MediaQuery
                    .of(context)
                    .size
                    .height) / 2.5),
            height: (MediaQuery
                .of(context)
                .size
                .height / 3.5),
            width: (MediaQuery
                .of(context)
                .size
                .width),
            //color: Colors.green,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                AnimatedBuilder(
                    animation: controller,
                    builder: (BuildContext context, Widget child) {
                      return Text(
                        getRatingDefinition(),
                        style: Theme
                            .of(context)
                            .textTheme
                            .subtitle,
                        textAlign: TextAlign.center,
                      );
                    }),

                Divider(
                  indent: 100,
                  endIndent: 100,
                  color: Colors.white,
                  thickness: 3,
                ),
                Container(
                  padding: EdgeInsets.only(left: 50, right: 50),
                  child:
                  AnimatedBuilder(
                      animation: controller,
                      builder: (BuildContext context, Widget child) {
                        return Text(
                          getRatingText(),
                          textAlign: TextAlign.center,
                          style: Theme
                              .of(context)
                              .textTheme
                              .display1,
                        );
                      }),

                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,

            ///Animation zum bewerten
            child: GestureDetector(
              onHorizontalDragStart: (DragStartDetails details) =>
                  dragStart(context, details),
              onHorizontalDragUpdate: (DragUpdateDetails details) =>
                  dragUpdate(context, details),
              onHorizontalDragDown: (DragDownDetails details) =>
                  dragDown(context, details),
              child: AnimatedBuilder(
                animation: this.controller,
                builder: (BuildContext context, Widget child) {
                  return CustomPaint(
                      painter: CustomRateWorkoutPainter(
                        animation: this.controller,
                        backgroundColor: Colors.white,
                        color: Theme
                            .of(context)
                            .accentColor,
                        posX: this.posx,
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void dragStart(BuildContext context, DragStartDetails details) {
    //print('Start: ${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);

    setState(() {
      posx = localOffset.dx;
      posy = localOffset.dy;
      this.tapInProgress = true;
    });
  }

  dragDown(BuildContext context, DragDownDetails details) {
    //print('Ende: ${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);

    setState(() {
      posx = localOffset.dx;
      posy = localOffset.dy;
      this.tapInProgress = true;
    });
  }

  void dragUpdate(BuildContext context, DragUpdateDetails details) {
    //print('${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);

    setState(() {
      posx = localOffset.dx;
      posy = localOffset.dy;
      this.controller.value = localOffset.dx;
      this.tapInProgress = true;
    });
  }

  String getCurrentRating(BuildContext context) {
    double size = MediaQuery
        .of(context)
        .size
        .width;
    double alt = 0;
    int index = 0;
    for (double i = 0; i < size + 1; i = i + size / 10) {
      if (this.posx <= i && this.posx >= alt) {
        return "$index";
      }
      alt = i;
      index++;
    }
    return "Fehler";
  }

  String getRatingDefinition() {
    double size = MediaQuery
        .of(context)
        .size
        .width;
    double alt = 0;
    int index = 0;
    for (double i = 0; i < size + 1; i = i + size / 10) {
      if (this.posx <= i && this.posx >= alt) {
        this.rating = index;
        return ratingDefinition(index);
      }
      alt = i;
      index++;
    }
    return "Fehler";
  }

  String getRatingText() {
    double size = MediaQuery
        .of(context)
        .size
        .width;
    double alt = 0;
    int index = 0;
    for (double i = 0; i < size + 1; i = i + size / 10) {
      if (this.posx <= i && this.posx >= alt) {
        return ratingText(index);
      }
      alt = i;
      index++;
    }
    return "Fehler";
  }

  void moveToDoneWorkoutScreen() {
    widget.workoutInformation.rating = this.rating;
    saveNewWorkout();
  }

  String ratingText(int i) {
    String erg = "";
    switch (i) {
      case 1:
        erg = "Normale Atmung. Das war keine Anstrengung.";
        break;
      case 2:
        erg =
        "Leicht erhöhte Atmung. Das war keine besonders große Anstrengung.";
        break;
      case 3:
        erg = "Erhöhte Atmung. Das war etwas anstrengend.";
        break;
      case 4:
        erg =
        "Erhöhte Atmung und etwas erhöhter Puls. Es war etwas anstrengend aber keine Herausforderung.";
        break;
      case 5:
        erg = "Erhöhte Atmung und erhöhter Puls. Das war anstrengend.";
        break;
      case 6:
        erg = "Sprechen fällt schwerer. Das war anstrengend.";
        break;
      case 7:
        erg = "Sprechen nur schwer möglich. Das war ziemlich anstrengend.";
        break;
      case 8:
        erg = "Sprechen nur sehr schwer möglich. Das war echt anstrengend.";
        break;
      case 9:
        erg = "Sprechen sehr schwer möglich. Das war anstrengend.";
        break;
      case 10:
        erg = "Sprechen nicht möglich. Das war extrem anstrengend.";
        break;
    }
    return erg;
  }

  String ratingDefinition(int i) {
    String erg = "";
    switch (i) {
      case 1:
        erg = "Super Einfach";
        break;
      case 2:
        erg = "Sehr Einfach";
        break;
      case 3:
        erg = "Leicht";
        break;
      case 4:
        erg = "Etwas Anstrengend";
        break;
      case 5:
        erg = "Anstrengend";
        break;
      case 6:
        erg = "Sehr Anstrengend.";
        break;
      case 7:
        erg = "Etwas Schwer";
        break;
      case 8:
        erg = "Schwer";
        break;
      case 9:
        erg = "Ziemlich Schwer";
        break;
      case 10:
        erg = "Extreme Herausforderung";
        break;
    }
    return erg;
  }

  Future saveNewWorkout() async {
    int x = await dbHelperWorkouts.queryRowCount();
        double duration = (widget.workoutInformation.getRoundLengthMin() + (widget.workoutInformation.getRoundLengthSec() / 60) );
    double burnedkcal = this.weight/5 * duration;
    print("weight ${this.weight}");
    widget.workoutInformation.kcal = burnedkcal;
    DateTime dt = new DateTime.now();

    Map<String, dynamic> row = {
      WorkoutDatabaseHelper.columnId: x+1,
      WorkoutDatabaseHelper.columnType: widget.workoutInformation.type,
      WorkoutDatabaseHelper.columnBurnedCalories: burnedkcal,
      WorkoutDatabaseHelper.columnDuration: duration,
      WorkoutDatabaseHelper.columnTrainingYear: dt.year,
      WorkoutDatabaseHelper.columnTrainingMonth: dt.month,
      WorkoutDatabaseHelper.columnTrainingDay: dt.day,
      WorkoutDatabaseHelper.columnTechniques: widget.workoutInformation.techniques.toString(),
      WorkoutDatabaseHelper.columnWeekDay: 'Freitag',
    };
    print("row: $row");
    dbHelperWorkouts.insert(row);


    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
    print("Change to Done-Workout-Screen");
    Navigator.push(context, MaterialPageRoute(builder: (context) => DoneWorkoutScreen(widget.workoutInformation)),);

  }

  Future<Null> setDouble(String key, double w) async {
    await this.prefs.setDouble(key, w);
    print("Double saved");
  }

  void loadDouble(String key) async {
    setState(() {
      this.weight = prefs.get(key) ?? 0;
    });
  }

}
