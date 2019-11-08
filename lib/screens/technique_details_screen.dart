import 'package:flutter/material.dart';
import 'package:uebung02/screens/reusable_widgets.dart';

class TechniqueDetailsScreen extends StatelessWidget {

  ReusableWidgets _reusableWidgets;

  @override
  Widget build(BuildContext context) {
    _reusableWidgets = new ReusableWidgets(context, -1);

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
                  child: Text("Name der Technik", style: Theme.of(context).textTheme.display4),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Info", style: Theme.of(context).textTheme.body2),
                    Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
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
