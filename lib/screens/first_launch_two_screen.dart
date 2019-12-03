import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uebung02/screens/reusable_widgets.dart';

import 'first_launch_three_screen.dart';

class FirstLaunchScreenTwo extends StatefulWidget {
  @override
  _FirstLaunchScreenTwoState createState() => _FirstLaunchScreenTwoState();
}

class _FirstLaunchScreenTwoState extends State<FirstLaunchScreenTwo> {
  ReusableWidgets r;
  SharedPreferences prefs;

  int radioButtonValue = 0;
  bool switchVal = false;

  TextEditingController dayTextController;
  TextEditingController monthTextController;
  TextEditingController yearTextController;
  TextEditingController nameTextController;
  TextEditingController emailTextController;
  TextEditingController dayPerWeekTextController;
  TextEditingController weightTextController;
  TextEditingController sizeTextController;



  @override
  void initState() {
    super.initState();
    r = new ReusableWidgets(context, -1);

    dayTextController = new TextEditingController();
    monthTextController = new TextEditingController();
    yearTextController = new TextEditingController();
    nameTextController = new TextEditingController();
    emailTextController = new TextEditingController();
    dayPerWeekTextController = new TextEditingController();
    weightTextController = new TextEditingController();
    sizeTextController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: r.getAppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Card(
                shape: new RoundedRectangleBorder(
                    side: new BorderSide(
                        color: Color.fromRGBO(200, 0, 0, 1), width: 2.0),
                    borderRadius: BorderRadius.circular(4.0)),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Name", style: Theme.of(context).textTheme.display4),
                      Container(
                        width: 250,
                        height: 30,
                        child: TextField(
                          controller: nameTextController,
                          decoration: new InputDecoration(),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: new RoundedRectangleBorder(
                    side: new BorderSide(
                        color: Color.fromRGBO(200, 0, 0, 1), width: 2.0),
                    borderRadius: BorderRadius.circular(4.0)),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Email", style: Theme.of(context).textTheme.display4),
                      Container(
                        width: 250,
                        height: 30,
                        child: TextField(
                          controller: emailTextController,
                          decoration: new InputDecoration(),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: new RoundedRectangleBorder(
                    side: new BorderSide(
                        color: Color.fromRGBO(200, 0, 0, 1), width: 2.0),
                    borderRadius: BorderRadius.circular(4.0)),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Geschlecht",
                          style: Theme.of(context).textTheme.display4),
                      Column(
                        children: <Widget>[
                          Text("Weiblich",
                              style: Theme.of(context).textTheme.body2),
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
                ),
              ),
              Card(
                shape: new RoundedRectangleBorder(
                    side: new BorderSide(
                        color: Color.fromRGBO(200, 0, 0, 1), width: 2.0),
                    borderRadius: BorderRadius.circular(4.0)),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Geburtstag",
                          style: Theme.of(context).textTheme.display4),
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
                ),
              ),
              Card(
                shape: new RoundedRectangleBorder(
                    side: new BorderSide(
                        color: Color.fromRGBO(200, 0, 0, 1), width: 2.0),
                    borderRadius: BorderRadius.circular(4.0)),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Gewicht",
                          style: Theme.of(context).textTheme.display4),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              width: 50,
                              height: 30,
                              child: TextField(
                                controller: weightTextController,
                                decoration: new InputDecoration(),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true, signed: true),
                              ),
                            ),
                            Text("kg",
                                style: Theme.of(context).textTheme.body2),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: new RoundedRectangleBorder(
                    side: new BorderSide(
                        color: Color.fromRGBO(200, 0, 0, 1), width: 2.0),
                    borderRadius: BorderRadius.circular(4.0)),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Größe",
                          style: Theme.of(context).textTheme.display4),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 50,
                              height: 30,
                              margin: EdgeInsets.only(right: 10),
                              child: TextField(
                                controller: sizeTextController,
                                decoration: new InputDecoration(),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: false, signed: true),
                              ),
                            ),
                            Text("cm",
                                style: Theme.of(context).textTheme.body2),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: new RoundedRectangleBorder(
                    side: new BorderSide(
                        color: Color.fromRGBO(200, 0, 0, 1), width: 2.0),
                    borderRadius: BorderRadius.circular(4.0)),
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Trainingsrinnerung",
                                style: Theme.of(context).textTheme.display4),
                            Switch(
                              value: this.switchVal,
                              onChanged: (bool value) {
                                setState(() {
                                  this.switchVal = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.black54,
                        ),
                        Row(
                          children: <Widget>[
                            Text("Tage pro Woche",
                                style: Theme.of(context).textTheme.body2),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              width: 50,
                              height: 30,
                              child: TextField(
                                enabled: this.switchVal,
                                controller: dayPerWeekTextController,
                                decoration: new InputDecoration(),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: false, signed: true),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
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
                  onPressed: showNextScreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleRadioButtonValueChange(int value) {
    setState(() {
      this.radioButtonValue = value;
    });
  }

//TODO: Shared Prefs

  void showNextScreen() {
    try{
      String name = this.nameTextController.text;
      String email = this.emailTextController.text;
      String gender = (radioButtonValue==0) ? "Weiblich" : "Männlich";
      int year = int.parse(this.yearTextController.text);
      int month = int.parse(this.monthTextController.text);
      int day = int.parse(this.dayTextController.text);
      double weight = double.parse(this.weightTextController.text);
      int size = int.parse(this.sizeTextController.text);
      int trainingdays;
      if (this.switchVal){
        trainingdays  = int.parse(this.dayPerWeekTextController.text);
      } else {
        trainingdays = 0;
      }

      int birthday = year*10000 + month*100 + day;
      print("birthday: $birthday");

      SharedPreferences.getInstance().then((sp) {
        this.prefs = sp;
        setString(userNameKey, name);
        setString(userEmailKey, email);
        setString(userGenderKey, gender);
        setInt(userSizeKey, size);
        setDouble(userWeightKey, weight);
        setInt(userBirthdayKey, birthday);
        setInt(trainingDaysKey, trainingdays);
      });
    }catch(e){
      print(e);
    }


    Navigator.push(context,
        MaterialPageRoute(builder: (context) => FirstLaunchScreenThree()));
  }

  Future<Null> setDouble(String key, double w) async {
    await this.prefs.setDouble(key, w);
    print("Double saved $w");
  }

  Future<Null> setString(String key, String g) async {
    await this.prefs.setString(key, g);
    print("String saved $g");
  }

  Future<Null> setInt(String key, int w) async {
    await this.prefs.setInt(key, w);
    print("Int saved $w");
  }

  static const String userWeightKey = 'userWeight';
  static const String userGenderKey = 'userGender';
  static const String userSizeKey = 'userSize';
  static const String userNameKey = 'userName';
  static const String userEmailKey = 'userEmail';
  static const String userBirthdayKey = 'userBirthday';
  static const String trainingDaysKey = 'userTrainingDays';
}
