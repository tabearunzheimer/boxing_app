import 'package:flutter/material.dart';
import 'package:uebung02/helper/CustomTimerPainter.dart';
import 'package:uebung02/helper/current_workout_information.dart';
import 'package:uebung02/screens/reusable_widgets.dart';

class WorkoutScreen extends StatefulWidget {
  CurrentWorkoutInformation workoutInformation;

  WorkoutScreen(CurrentWorkoutInformation cOld) {
    this.workoutInformation = cOld;
  }

  @override
  _WorkoutScreenState createState() => new _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  int doneRounds;
  bool breakDone;

  @override
  void initState() {
    super.initState();
    doneRounds = 1;
    breakDone = false;

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.workoutInformation.getRoundLength()),
    );
    controller.addListener(() {
      this.setState(() {});
    });
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print("completed");
      } else if (status == AnimationStatus.dismissed) {
        controller.reverse();
        print("StatusController - restart");
        startNewTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ReusableWidgets _reusableWidgets = new ReusableWidgets(context, -1);

    return Scaffold(
      appBar: _reusableWidgets.getSimpleAppBar(),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: new Image.asset(
              'assets/img/female_boxer.jpg',
              fit: BoxFit.fill,
              height: 900.0,
            ),
          ),
          Container(
            //margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height) / 4),
            margin: EdgeInsets.fromLTRB(
                50, (MediaQuery.of(context).size.height) / 4, 50, 50),
            height: (MediaQuery.of(context).size.height / 4),
            width: (MediaQuery.of(context).size.width),
            child: AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, Widget child) {
                return CustomPaint(
                    painter: CustomTimerPainter(
                  animation: controller,
                  backgroundColor: Colors.white,
                  color: Theme.of(context).accentColor,
                ));
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: (MediaQuery.of(context).size.height) / 4.8),
            height: (MediaQuery.of(context).size.height / 8),
            width: (MediaQuery.of(context).size.width),
            //color: Colors.green,
            alignment: Alignment.center,
            child: Text(this.breakDone ? "Pause" : "Training",
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: (MediaQuery.of(context).size.height) / 3.8),
            height: (MediaQuery.of(context).size.height / 4),
            width: (MediaQuery.of(context).size.width),
            alignment: Alignment.center,
            child: AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, Widget child) {
                  return Text(
                    '${getTimerString()}',
                    style: TextStyle(fontSize: 112.0, color: Colors.white),
                  );
                }),
          ),
          Container(
            margin: EdgeInsets.only(
              top: (MediaQuery.of(context).size.height) / 1.8,
            ),
            //color: Colors.green,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return FloatingActionButton.extended(
                    onPressed: () {
                      setState(() {
                        if (controller.isAnimating)
                          controller.stop();
                        else {
                          controller.reverse(
                              from: controller.value == 0.0
                                  ? 1.0
                                  : controller.value);
                        }
                      });
                    },
                    icon: Icon(controller.isAnimating
                        ? Icons.pause
                        : Icons.play_arrow),
                    label: Text(controller.isAnimating ? "Pause" : "Play"),
                  );
                }),
          ),
          Container(
            margin: EdgeInsets.only(
              top: (MediaQuery.of(context).size.height) / 10,
            ),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Text(
              '${getRoundStatus()}',
              style: TextStyle(
                  color: Colors.white, fontSize: 18, fontFamily: 'Roboto'),
            ),
          ),
          WillPopScope(
            onWillPop: backButtonAlert,
            child: Container(),
          ),
        ],
      ),
    );
  }

  String getTimerString() {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  String getRoundStatus() {
    int roundAmount = widget.workoutInformation.getRoundAmount();
    if (roundAmount == 0) {
      return "${this.doneRounds}/1";
    } else {
      return "${this.doneRounds}/${roundAmount}";
    }
  }

  void checkTimer() {
    if (!controller.isAnimating) {
      print(controller.value);
    }
  }

  void startNewTimer() {
    if (checkForRepeat()) {
      print("Repeat war true");
      if (checkForBreak() && !this.breakDone) {
        print("Pause war true");
        //starte Timer mit neuer Zeit fuer Pause
        this.breakDone = true;
        controller.reset();
        controller.duration = Duration(seconds: widget.workoutInformation.getBreakTime());
        controller.reverse(from: 1.0);
      } else {
        print("Runde war true");
        this.doneRounds++;
        this.breakDone = false;
        controller.reset();
        controller.duration = Duration(seconds: widget.workoutInformation.getRoundLength());
        controller.reverse(from: 1.0);
      }
    } else {
      //oeffne getaenes Workout screen
    }
  }

  bool checkForRepeat() {
    int roundAmount = widget.workoutInformation.getRoundAmount();
    if (this.doneRounds < roundAmount) {
      return true;
    } else {
      return false;
    }
  }

  bool checkForBreak() {
    int breakTime = widget.workoutInformation.getBreakTime();
    if (breakTime == 0) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> backButtonAlert() {
    showDialog(
        context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Vorsicht!"),
        content: Text("Wenn Sie zurück klicken wird das Workout abgebrochen."),
        actions: <Widget>[
          FlatButton(
            child: Text("Verlassen"),
            onPressed: (){
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text("Abbrechen"),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
