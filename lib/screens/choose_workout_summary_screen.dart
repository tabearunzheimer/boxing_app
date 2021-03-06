import 'package:flutter/material.dart';
import 'package:uebung02/helper/Technique.dart';
import 'package:uebung02/helper/current_workout_information.dart';
import 'package:uebung02/screens/reusable_widgets.dart';
import 'package:uebung02/screens/workout_screen.dart';

import 'music_screen.dart';

class ChooseWorkoutSummaryScreen extends StatefulWidget {
  CurrentWorkoutInformation workoutInformation;

  ChooseWorkoutSummaryScreen(CurrentWorkoutInformation cOld) {
    this.workoutInformation = cOld;
  }

  @override
  _ChooseWorkoutSummaryScreenState createState() =>
      new _ChooseWorkoutSummaryScreenState();
}



class _ChooseWorkoutSummaryScreenState extends State<ChooseWorkoutSummaryScreen> {

  List<Technique> list;
  ReusableWidgets _reusableWidgets;

  @override
  Widget build(BuildContext context) {
    _reusableWidgets = new ReusableWidgets(context, -1);
    this.list = widget.workoutInformation.getTechniques();

    return Scaffold(
        appBar: _reusableWidgets.getSimpleAppBar(),
        body: ListView.separated(
          separatorBuilder: (context, index) =>
              Divider(
                color: Color.fromRGBO(0, 0, 0, 0.8),
              ),
          //padding: EdgeInsets.all(10.0),
          shrinkWrap: true,
          itemCount: (this.list.length + 2),
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(bottom: 10),
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildFirstListItem();
            }
            if (index == 1) {
              return Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                    widget.workoutInformation.getType() == "Reaktion" ? "Techniken" : "Playlist",
                    style: Theme.of(context).textTheme.display2,
                ),
              );
            }
            index -= 2;
            return _buildListItems(index);
          },
        )
    );
  }

  ///returns a stack with a picture in the background, some motivational quote and the current workout information
  Widget _buildFirstListItem(){
    return Stack(
      children: <Widget>[
        Container(
          width: (MediaQuery.of(context).size.width),
          height: (MediaQuery.of(context).size.height),
         child: Image.asset('assets/img/female_boxer.jpg',fit: BoxFit.fill),
        ),
        Container(
          height: MediaQuery.of(context).size.height - (_reusableWidgets.getSimpleAppBar().preferredSize.height),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height / 5)),
                width: (MediaQuery.of(context).size.width),
                height: (MediaQuery.of(context).size.height / 8),
                alignment: Alignment.center,
                //color: Colors.red,
                child: Text("Gib alles", style: Theme.of(context).textTheme.headline,),

              ),
              Container(
                //color: Colors.green,
                height: (MediaQuery.of(context).size.height / 2) + 50,
                padding: EdgeInsets.all(20),
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 10, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text("Art", textAlign: TextAlign.end,),
                              Text("${widget.workoutInformation.getType()}"),
                            ],
                          ),
                          Container(
                              height: 40,
                              child: VerticalDivider(
                                color: Colors.white,
                                thickness: 2.0,)
                          ),
                          Column(
                            children: <Widget>[
                              Text("Runden"),
                              Text("${widget.workoutInformation.getRoundAmount()}"),
                            ],
                          ),
                          Container(
                              height: 40,
                              child: VerticalDivider(
                                color: Colors.white,
                                thickness: 2.0,)
                          ),
                          Column(
                            children: <Widget>[
                              Text("Dauer"),
                              Text("${widget.workoutInformation.getRoundLengthMin()}:${widget.workoutInformation.getRoundLengthSec()}"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: 100.0,
                          width: 100.0,
                          child: RawMaterialButton(
                            shape: CircleBorder(),
                            fillColor: Color.fromRGBO(255, 255, 255, 1),
                            child: Text("Start", style: Theme.of(context).textTheme.body2,),
                            onPressed: sendToWorkoutScreen,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///returns the techniques you're training as a list
  Widget _buildListItems(int index) {
      return new ListTile(
        title: Text(this.list[index].getName(), style: Theme.of(context).textTheme.display2,),
        subtitle: Text("Zuletzt: 06. November 2019", style: Theme.of(context).textTheme.display3,),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.security, color: Colors.black,),
              onPressed: null,
            ),
            IconButton(
              icon: Icon(Icons.music_note, color: Colors.black,),
              onPressed: null,
            ),
          ],
        ),
        onTap: () {},
      );

  }

  ///opens the next screen where you can start your workout
  void sendToWorkoutScreen() {
    print("Change to Workout-Screen");
    Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutScreen(widget.workoutInformation)),
  );
  }
}
