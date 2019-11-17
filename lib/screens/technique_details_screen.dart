import 'package:flutter/material.dart';
import 'package:uebung02/helper/Technique.dart';
import 'package:uebung02/screens/reusable_widgets.dart';

class TechniqueDetailsScreen extends StatefulWidget {

  Technique tech;

  TechniqueDetailsScreen(Technique t) {
    this.tech = t;
  }

  @override
  _TechniqueDetailsScreenState createState() =>
      new _TechniqueDetailsScreenState();

}

class _TechniqueDetailsScreenState extends State<TechniqueDetailsScreen> {


  ReusableWidgets _reusableWidgets;

  @override
  Widget build(BuildContext context) {
    _reusableWidgets = new ReusableWidgets(context, -1);
      print("Name: ${widget.tech.getName()}");

    return Scaffold(
      appBar: _reusableWidgets.getSimpleAppBar(),
      body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text("${widget.tech.getName()}", style: Theme.of(context).textTheme.display4),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Info", style: Theme.of(context).textTheme.body2),
                    Text("${widget.tech.getErklaerung()}",
                      style: Theme.of(context).textTheme.body2,
                    ),
                    Divider(
                      color: Colors.black54,
                    ),
                    Text("${widget.tech.getLink()}",
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ],
                ),
              ),
            ],
        ),
      ),
    );
  }
}
