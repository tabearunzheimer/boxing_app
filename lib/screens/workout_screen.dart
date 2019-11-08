import 'package:flutter/material.dart';
import 'package:uebung02/screens/reusable_widgets.dart';

class WorkoutScreen extends StatefulWidget {
  @override
  _WorkoutScreenState createState() => new _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> with TickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    ReusableWidgets _reusableWidgets = new ReusableWidgets(context, -1);
    return Scaffold(
      appBar: _reusableWidgets.getSimpleAppBar(),
      body:
      Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: new Image.asset('assets/img/female_boxer.jpg', fit: BoxFit.fill, height: 900.0,),
          ),
          Container(
            margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height) / 4),
            height: (MediaQuery.of(context).size.height / 4),
            //color: Colors.red,
            child: Center(
              child: Text("Timer", style: TextStyle(fontSize: 50.0,),),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height) / 1.8,),
            //color: Colors.green,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Pause/ Start", style: TextStyle(fontSize: 30.0,),),
                Text("Abbrechen", style: TextStyle(fontSize: 30.0,),),
              ]
            ),
          ),
        ],
      ),
    );
  }

}
