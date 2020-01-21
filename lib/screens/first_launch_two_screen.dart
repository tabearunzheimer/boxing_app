import 'package:flushbar/flushbar.dart';
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

  String errorText ="";

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

  bool validateDay(int day, int month){
    if (day < 0){
      errorText  = " Bitte gib einen korrekten Tag an";
      return false;
    } else if (month == 2 && day > 29) {
      errorText = "Bitte gib einen korrekten Tag an";
      return false;
    } else if ((month%2) != 0 && day > 31){
      errorText = "Bitte gib einen korrekten Tag an";
      return false;
    } else if ((month%2) == 0 && day > 30){
      errorText = "Bitte gib einen korrekten Monat an";
      return false;
    }
    return true;
  }

  bool validateMonth(int month){
    if (month < 1) {
      errorText = "Bitte gib einen korrekten Monat an";
      return false;
    } else if (month > 12){
      errorText = "Bitte gib einen korrekten Monat an";
      return false;
    }
    return true;
  }

  bool validateYear(int year){
    if (year < 1850){
      errorText = "Bitte gib einen korrekten Monat an";
      return false;
    } else if (year > DateTime.now().year){
      errorText = "Bitte gib ein korrektes Jahr an";
      return false;
    }
    return true;
  }

  //TODO
  bool validateMail(String mail){
    return true;
  }

  bool validateDaysPerWeek(int days){
    if (days < 0){
      errorText = "Bitte gib einen Wert größer als 1 an.";
      return false;
    } else if (days > 7){
      errorText = "Aus gesundheitlichen Gründen werden nicht mehr als 7 Trainingstage pro Woche unterstützt.";
      return false;
    }
    return true;
  }

  bool validateWeight(double weight){
    print("weight $weight");
    if (weight < 30){
      errorText = "Bitte gib für dein Gewicht einen Wert größer als 30 an.";
      return false;
    } else if (weight > 200){
      errorText = "Bitte gib für dein Gewicht einen Wert kleiner als 200 an.";
      return false;
    }
    return true;
  }

  bool validateSize(int size){
    if (size < 30){
      errorText = "Bitte gib für deine Größe mit einem Wert größer als 30 an.";
      return false;
    } else if (size > 300){
      errorText = "Bitte gib für deine Größe einen Wert kleiner als 300 an.";
      return false;
    }
    return true;
  }

  bool validateBirthday(DateTime birth){
    if (birth.isAfter(DateTime.now())){
      errorText = "Bitte gib einen korrekten Wert an.";
      return false;
    }
    return true;
  }

  Widget showNextScreen() {
    String name = "";
    String email = "";
    String gender = "";
    int year = 0;
    int month = 0;
    int day = 0;
    double weight = 0;
    int size = 0;
    int trainingdays = 0;

    try{
      name = this.nameTextController.text;
    }catch(e){
      print("Fehler bei try and catch $e");
    }
    try{
      email = this.emailTextController.text;
    }catch(e){
      print("Fehler bei try and catch $e");
    }
    try{
      gender = (radioButtonValue==0) ? "Weiblich" : "Männlich";
    }catch(e){
      print("Fehler bei try and catch $e");
    }
    try{
      year = int.parse(this.yearTextController.text);
    }catch(e){
      print("Fehler bei try and catch $e");
    }
    try{
      month = int.parse(this.monthTextController.text);
    }catch(e){
      print("Fehler bei try and catch $e");
    }
    try{
      day = int.parse(this.dayTextController.text);
    }catch(e){
      print("Fehler bei try and catch $e");
    }
    try{
      weight = double.parse(this.weightTextController.text);
    }catch(e){
      print("Fehler bei try and catch $e");
    }
    try{
      size = int.parse(this.sizeTextController.text);
    }catch(e){
      print("Fehler bei try and catch $e");
    }
    try{
      trainingdays = int.parse(this.dayPerWeekTextController.text);
    }catch(e){
      print("Fehler bei try and catch $e");
    }



    if (validateDay(day, month) && validateDaysPerWeek(trainingdays) && validateMail(email) && validateMonth(month) && validateYear(year) && validateSize(size) && validateWeight(weight) && validateBirthday(DateTime(year, month, day))){
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

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => FirstLaunchScreenThree()));
    } else {
      print("Fehler beim validieren");
      Flushbar(
        title: "Hinweis",
        message: "$errorText",
        backgroundColor: Colors.black54,
        margin: EdgeInsets.all(10),
        borderRadius: 10,
        duration: Duration(seconds: 3),
      )..show(context);
    }
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
