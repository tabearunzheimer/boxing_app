import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uebung02/helper/CustomRateWorkoutPainter.dart';
import 'package:uebung02/screens/reusable_widgets.dart';

class RateWorkoutScreen extends StatefulWidget {
  @override
  _RateWorkoutScreenState createState() => _RateWorkoutScreenState();
}

class _RateWorkoutScreenState extends State<RateWorkoutScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  bool tapInProgress;
  double posx = 100.0;
  double posy = 100.0;

  @override
  void initState() {
    super.initState();
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
          /*
          Container(
            margin: EdgeInsets.only(
                top: (MediaQuery.of(context).size.height) / 16),
            height: (MediaQuery.of(context).size.height / 8),
            width: (MediaQuery.of(context).size.width),
            padding: EdgeInsets.fromLTRB(60, 10, 60, 0),
            //color: Colors.green,
            alignment: Alignment.center,
            child: Text(
              "Wie fühlst du dich?",
              style: TextStyle(color: Colors.white, fontFamily: 'Staatliches', fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
           */

          Container(
            margin:
                EdgeInsets.only(top: (MediaQuery.of(context).size.height) / 5),
            height: (MediaQuery.of(context).size.height / 7),
            width: (MediaQuery.of(context).size.width),
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
                top: (MediaQuery.of(context).size.height) / 2.5),
            height: (MediaQuery.of(context).size.height / 3.5),
            width: (MediaQuery.of(context).size.width),
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
                        style: Theme.of(context).textTheme.subtitle,
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
                          style: Theme.of(context).textTheme.display1,
                        );
                      }),

                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,

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
                    color: Theme.of(context).accentColor,
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
    print('Start: ${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);

    setState(() {
      posx = localOffset.dx;
      posy = localOffset.dy;
      this.tapInProgress = true;
    });
  }

  dragDown(BuildContext context, DragDownDetails details) {
    print('Ende: ${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);

    setState(() {
      posx = localOffset.dx;
      posy = localOffset.dy;
      this.tapInProgress = true;
    });
  }

  void dragUpdate(BuildContext context, DragUpdateDetails details) {
    print('${details.globalPosition}');
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
    double size = MediaQuery.of(context).size.width;
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
    double size = MediaQuery.of(context).size.width;
    double alt = 0;
    int index = 0;
    for (double i = 0; i < size + 1; i = i + size / 10) {
      if (this.posx <= i && this.posx >= alt) {
        return " Wertung: $index";
      }
      alt = i;
      index++;
    }
    return "Fehler";
  }

  String getRatingText() {
    double size = MediaQuery.of(context).size.width;
    double alt = 0;
    int index = 0;
    for (double i = 0; i < size + 1; i = i + size / 10) {
      if (this.posx <= i && this.posx >= alt) {
        return "Bewertungstext $index\n Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam";
      }
      alt = i;
      index++;
    }
    return "Fehler";
  }

  void moveToDoneWorkoutScreen() {
    ///Uebergang zum naechsten screen
  }
}
