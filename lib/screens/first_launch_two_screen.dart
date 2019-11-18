import 'package:flutter/material.dart';
import 'package:uebung02/screens/reusable_widgets.dart';

class FirstLaunchScreenTwo extends StatefulWidget {
  @override
  _FirstLaunchScreenTwoState createState() => _FirstLaunchScreenTwoState();
}

class _FirstLaunchScreenTwoState extends State<FirstLaunchScreenTwo> {
  ReusableWidgets r;

  int radioButtonValue = 0;

  TextEditingController dayTextController;
  TextEditingController monthTextController;
  TextEditingController yearTextController;

  @override
  void initState() {
    super.initState();
    r = new ReusableWidgets(context, -1);
    dayTextController = new TextEditingController();
    monthTextController = new TextEditingController();
    yearTextController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: r.getAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Name", style: Theme.of(context).textTheme.display4),
              Container(
                width: 250,
                height: 30,
                child: TextField(
                  //controller: dayTextController,
                  decoration: new InputDecoration(),
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Geschlecht", style: Theme.of(context).textTheme.display4),
              Column(
                children: <Widget>[
                  Text("Weiblich", style: Theme.of(context).textTheme.body2),
                  Radio(
                    value: 0,
                    groupValue: radioButtonValue,
                    onChanged: handleRadioButtonValueChange,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    "Männlich",
                    style: Theme.of(context).textTheme.body2,
                  ),
                  Radio(
                    value: 1,
                    groupValue: radioButtonValue,
                    onChanged: handleRadioButtonValueChange,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Alter", style: Theme.of(context).textTheme.display4),
              Column(
                children: <Widget>[
                  Text("Tag", style: Theme.of(context).textTheme.body2),
                  Container(
                    width: 50,
                    height: 30,
                    child: TextField(
                      controller: dayTextController,
                      decoration: new InputDecoration(),
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: false, signed: true),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    "Monat",
                    style: Theme.of(context).textTheme.body2,
                  ),
                  Container(
                    width: 50,
                    height: 30,
                    child: TextField(
                      controller: monthTextController,
                      decoration: new InputDecoration(),
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: false, signed: true),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    "Jahr",
                    style: Theme.of(context).textTheme.body2,
                  ),
                  Container(
                    width: 50,
                    height: 30,
                    child: TextField(
                      controller: yearTextController,
                      decoration: new InputDecoration(),
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: false, signed: true),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Gewicht", style: Theme.of(context).textTheme.display4),
              Container(
                width: 50,
                height: 30,
                child: TextField(
                  //controller: dayTextController,
                  decoration: new InputDecoration(),
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: false, signed: true),
                ),
              ),
              Text("kg", style: Theme.of(context).textTheme.body2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Größe", style: Theme.of(context).textTheme.display4),
              Container(
                width: 50,
                height: 30,
                child: TextField(
                  //controller: dayTextController,
                  decoration: new InputDecoration(),
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: false, signed: true),
                ),
              ),
              Text("cm", style: Theme.of(context).textTheme.body2),
            ],
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.only(right: 20),
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.check,
                color: Colors.black,
              ),
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FirstLaunchScreenTwo()));
              },
            ),
          ),
        ],
      ),
    );
  }

  void handleRadioButtonValueChange(int value) {
    setState(() {
      this.radioButtonValue = value;
    });
  }
}
