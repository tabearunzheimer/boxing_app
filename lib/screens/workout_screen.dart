import 'package:flutter/material.dart';
import 'package:uebung02/helper/CustomTimerPainter.dart';
import 'package:uebung02/helper/current_workout_information.dart';
import 'package:uebung02/screens/reusable_widgets.dart';

class WorkoutScreen extends StatefulWidget {
  CurrentWorkoutInformation workoutInformation;

  WorkoutScreen(CurrentWorkoutInformation cOld){
    this.workoutInformation = cOld;
  }

  @override
  _WorkoutScreenState createState() => new _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen>
    with TickerProviderStateMixin {
  AnimationController controller;


  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.workoutInformation.getRoundLength()),
    );
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
            margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height) / 5),
            height: (MediaQuery.of(context).size.height / 8),
            width: (MediaQuery.of(context).size.width),
            //color: Colors.green,
            alignment: Alignment.center,
            child: Text("${widget.workoutInformation.getType()}", style: Theme.of(context).textTheme.subtitle,),
          ),
          Container(
            margin:
                EdgeInsets.only(top: (MediaQuery.of(context).size.height) / 4),
            height: (MediaQuery.of(context).size.height / 4),
            width: (MediaQuery.of(context).size.width),
            alignment: Alignment.center,
            child: AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, Widget child) {
                  return Text(
                    timerString,
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
                        if (controller.isAnimating)
                          controller.stop();
                        else {
                          controller.reverse(
                              from: controller.value == 0.0
                                  ? 1.0
                                  : controller.value);
                        }
                      },
                      icon: Icon(controller.isAnimating
                          ? Icons.pause
                          : Icons.play_arrow),
                      label: Text(controller.isAnimating ? "Pause" : "Play"));
                }),
          ),
        ],
      ),
    );
  }

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }



}
