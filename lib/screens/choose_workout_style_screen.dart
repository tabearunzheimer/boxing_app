import 'package:flutter/material.dart';
import 'package:uebung02/screens/reusable_widgets.dart';

class ChooseWorkoutStyleScreen extends StatefulWidget {
  @override
  _ChooseWorkoutStyleScreenState createState() =>
      new _ChooseWorkoutStyleScreenState();
}

ReusableWidgets _reusableWidgets;

class _ChooseWorkoutStyleScreenState extends State<ChooseWorkoutStyleScreen>
    with SingleTickerProviderStateMixin {

  List <Tab> l = [
    Tab(child: Text("Runden"),),
    Tab(child: Text("Reaktion"),),
    Tab(child: Text("Offen"),)
  ];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: l.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _reusableWidgets = new ReusableWidgets(context, -1);
    return new Scaffold(
      appBar: AppBar(
        title: Text("Kickbox App",),
        bottom: TabBar(
          controller: _tabController,
          tabs: l,
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            buildRundenAndReaktionElement('assets/img/man_boxer.jpg'),
            buildRundenAndReaktionElement('assets/img/hill_fighter_meditate.jpg'),
            buildOffenElement('assets/img/man_boxer.jpg'),
          ]
      ),
    );
  }

  Widget buildRundenAndReaktionElement(String imgPfad) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height,
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
                style: Theme
                    .of(context)
                    .textTheme
                    .body2,
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
                            Text("Anzahl der Runden: ",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body2,
                            ),
                            Text("0-99"),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text("Dauer pro Runde: ",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .body2,
                            ),
                            Text("min"),
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
                    onPressed: showChooseWorkoutTechniquesScreen,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOffenElement(String imgPfad) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height,
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
                style: Theme
                    .of(context)
                    .textTheme
                    .body2,
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
                        Text("Dauer pro Runde: ",
                          style: Theme
                              .of(context)
                              .textTheme
                              .body2,
                        ),
                        Text("min"),
                      ],
                    ),
                  ),
                  RawMaterialButton(
                    elevation: 10,
                    shape: CircleBorder(),
                    fillColor: Color.fromRGBO(255, 255, 255, 1),
                    child: Icon(Icons.arrow_forward),
                    onPressed: showChooseWorkoutTechniquesScreen,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  void showChooseWorkoutTechniquesScreen() {
    print("Change to choose-Workout-Techniques-Screen");
    Navigator.pushNamed(context, '/chooseWorkoutTechniques');
  }
}
