import 'package:flutter/material.dart';
import 'package:uebung02/screens/reusable_widgets.dart';

class MeScreen extends StatefulWidget {
  @override
  _MeScreenState createState() => new _MeScreenState();
}

int selectedIndex = 2;
ReusableWidgets _reusableWidgets;

class _MeScreenState extends State<MeScreen> {
  @override
  Widget build(BuildContext context) {
    _reusableWidgets = new ReusableWidgets(context, selectedIndex);
    return Scaffold(
      appBar: _reusableWidgets.getAppBar(),
      body:
      Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image(
            width: MediaQuery.of(context).size.width,
            image: AssetImage("assets/img/female_fighter_punch.jpg"),
            fit: BoxFit.fitWidth,
          ),
          Row(
            children: <Widget>[
              Text("Name", style: Theme.of(context).textTheme.body2,),
              IconButton(
                onPressed: null,
                icon: Icon(Icons.edit),
              ),
            ],
          ),
          Text("Email", style: Theme.of(context).textTheme.body2,),
          Divider(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            thickness: 3.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ButtonTheme(
                buttonColor: Color.fromRGBO(255, 255, 255, 0.8),
                minWidth: 140.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: RaisedButton(
                  disabledColor: Color.fromRGBO(0, 0, 0, 0.1),
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  child: Text("Geschlecht", style: Theme.of(context).textTheme.body2,),
                  onPressed: null,
                ),
              ),
              ButtonTheme(
                buttonColor: Color.fromRGBO(255, 255, 255, 0.8),
                minWidth: 140.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: RaisedButton(
                  disabledColor: Color.fromRGBO(0, 0, 0, 0.1),
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  child: Text("Alter", style: Theme.of(context).textTheme.body2,),
                  onPressed: null,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ButtonTheme(
                buttonColor: Color.fromRGBO(255, 255, 255, 0.8),
                minWidth: 140.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: RaisedButton(
                  disabledColor: Color.fromRGBO(0, 0, 0, 0.1),
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  child: Text("Gewicht", style: Theme.of(context).textTheme.body2,),
                  onPressed: null,
                ),
              ),
              ButtonTheme(
                buttonColor: Color.fromRGBO(255, 255, 255, 0.8),
                minWidth: 140.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: RaisedButton(
                  disabledColor: Color.fromRGBO(0, 0, 0, 0.1),
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  child: Text("Größe", style: Theme.of(context).textTheme.body2,),
                  onPressed: null,
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.9),
      bottomNavigationBar: _reusableWidgets.getBottomNavigataionBar(),
    );

  }
}
