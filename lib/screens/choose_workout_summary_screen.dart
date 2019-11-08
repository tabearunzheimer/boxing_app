import 'package:flutter/material.dart';
import 'package:uebung02/screens/reusable_widgets.dart';

class ChooseWorkoutSummaryScreen extends StatefulWidget {
  @override
  _ChooseWorkoutSummaryScreenState createState() =>
      new _ChooseWorkoutSummaryScreenState();
}

ReusableWidgets _reusableWidgets;

class _ChooseWorkoutSummaryScreenState
    extends State<ChooseWorkoutSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    _reusableWidgets = new ReusableWidgets(context, -1);
    List<String> list = [
      "Eins",
      "Zwei",
      "Drei",
      "Vier",
      "Fünf",
      "Sechs",
      "...",
      "...",
      "...",
      "...",
      "...",
      "...",
      "..."
    ];


    return Scaffold(
        appBar: _reusableWidgets.getSimpleAppBar(),
        body: ListView.separated(
          separatorBuilder: (context, index) =>
              Divider(
                color: Color.fromRGBO(0, 0, 0, 0.8),
              ),
          //padding: EdgeInsets.all(10.0),
          shrinkWrap: true,
          itemCount: list.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildFirstListItem();
            }
            if (index == 1) {
              return Container(
                padding: EdgeInsets.only(left: 10),
                child: Text("Techniken", style: Theme.of(context).textTheme.display2),
              );
            }
            index -= 2;
            return _buildListItems(list, index);
          },
        )
    );
  }

  Widget _buildFirstListItem(){
    return Stack(
      children: <Widget>[
        Image.asset('assets/img/female_boxer.jpg', height: 750.0, fit: BoxFit.fitHeight),
        Container(
          height: MediaQuery.of(context).size.height - (_reusableWidgets.getSimpleAppBar().preferredSize.height) - 30,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                width: (MediaQuery.of(context).size.width),
                height: (MediaQuery.of(context).size.height / 3),
                //color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        child: RawMaterialButton(
                          shape: CircleBorder(side: BorderSide(color: Colors.white, width: 1.5)),
                          child: Icon(Icons.music_note, color: Colors.white),
                          onPressed: null,
                        ),
                      ),
                    ),
                    Text("Gib alles", style: Theme.of(context).textTheme.headline,),
                  ],
                ),
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
                              Text("Runden"),
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
                              Text("3"),
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
                              Text("3 min"),
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
                            onPressed: (){
                              print("Change to Workout-Screen");
                              Navigator.pushNamed(context, '/WorkoutScreen');
                            },
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

  Widget _buildListItems(List<Object> l, int index) {
    return ListTile(
      title: Text(l[index], style: Theme
          .of(context)
          .textTheme
          .display4,),
      subtitle: Text("Zuletzt: 06. November 2019", style: Theme
          .of(context)
          .textTheme
          .display3,),
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

}
