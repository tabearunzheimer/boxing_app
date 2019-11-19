import 'package:flutter/material.dart';
import 'package:uebung02/helper/date_helper.dart';
import 'package:uebung02/screens/reusable_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeScreen extends StatefulWidget {
  @override
  _MeScreenState createState() => new _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {
  SharedPreferences prefs;
  double weight;
  String userName;
  String email;
  DateTime age;
  String gender;
  int userSize;
  int userTrainingDays;
  int selectedIndex = 2;
  ReusableWidgets _reusableWidgets;
  DateHelper datehelper = new DateHelper();

  static const String userWeightKey = 'userWeight';
  static const String userGenderKey = 'userGender';
  static const String userSizeKey = 'userSize';
  static const String userNameKey = 'userName';
  static const String userEmailKey = 'userEmail';
  static const String userBirthdayKey = 'userBirthday';
  static const String trainingDaysKey = 'userTrainingDays';

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sp) {
      this.prefs = sp;
      loadString(userNameKey);
      loadString(userEmailKey);
      loadString(userGenderKey);
      loadInt(userSizeKey);
      loadInt(userBirthdayKey);
      loadInt(trainingDaysKey);
      loadDouble(userWeightKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    _reusableWidgets = new ReusableWidgets(context, selectedIndex);
    /*
    setUserSize(163);
    setUserGender("Weiblich");
    setUserName("Tabea");
    setUserEmail("tabea.runzheimer@informatik.hs-fulda.de");
    */

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: _reusableWidgets.getAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildUserPicture(),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "$userName",
                        style: Theme.of(context).textTheme.display4,
                      ),
                      IconButton(
                        onPressed: null,
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                  Text(
                    "$email",
                    style: Theme.of(context).textTheme.body2,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 180.0,
                        height: 50.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Color.fromRGBO(200, 0, 0, 1),
                          disabledColor: Color.fromRGBO(200, 0, 0, 1),
                          child: Text(
                            "$gender",
                            style: Theme.of(context).textTheme.body1,
                          ),
                          onPressed: null,
                        ),
                      ),
                      Container(
                        width: 180.0,
                        height: 50.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Color.fromRGBO(200, 0, 0, 1),
                          disabledColor: Color.fromRGBO(200, 0, 0, 1),
                          child: Text(
                            "${this.age.day}\. ${datehelper.getMonthName(this.age.month)} ${this.age.year}",
                            style: Theme.of(context).textTheme.body1,
                          ),
                          onPressed: null,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 180.0,
                        height: 50.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Color.fromRGBO(200, 0, 0, 1),
                          disabledColor: Color.fromRGBO(200, 0, 0, 1),
                          child: Text(
                            "$weight kg",
                            style: Theme.of(context).textTheme.body1,
                          ),
                          onPressed: null,
                        ),
                      ),
                      Container(
                        width: 180.0,
                        height: 50.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Color.fromRGBO(200, 0, 0, 1),
                          disabledColor: Color.fromRGBO(200, 0, 0, 1),
                          child: Text(
                            "$userSize cm",
                            style: Theme.of(context).textTheme.body1,
                          ),
                          onPressed: null,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    height: 50.0,
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Color.fromRGBO(200, 0, 0, 1),
                      disabledColor: Color.fromRGBO(200, 0, 0, 1),
                      child: Text(
                        "Trainingstage pro Woche: ${this.userTrainingDays}",
                        style: Theme.of(context).textTheme.body1,
                      ),
                      onPressed: null,
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Zitat des Tages\nAll sounds and vibrations emanate from that Word. Your voice is a very powerful weapon. When you are in tune with the cosmic breath of heaven and earth, your voice produces true sounds. Unify body, mind and speech, and real techniques will emerge.\nMorihei Ueshiba (The Art of Peace)",
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ),
                ],
              ),
            ),
            WillPopScope(
              onWillPop: backButtonOverride,
              child: Container(),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.9),
      bottomNavigationBar: _reusableWidgets.getBottomNavigataionBar(),
    );
  }

  Widget buildUserPicture() {
    return Container(
      height: (MediaQuery.of(context).size.height / 3.5),
      width: (MediaQuery.of(context).size.width),
      child: Stack(
        children: <Widget>[
          Image(
            width: MediaQuery.of(context).size.width,
            image: AssetImage("assets/img/female_fighter_punch.jpg"),
            fit: BoxFit.fitWidth,
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.all(10),
            child: Container(
              height: 50.0,
              width: 50.0,
              child: RawMaterialButton(
                shape: CircleBorder(
                    side: BorderSide(color: Colors.white, width: 1.5)),
                child: Icon(Icons.camera_alt, color: Colors.white),
                onPressed: null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> setInt(String key, int w) async {
    await this.prefs.setInt(key, w);
    print("Int saved");
  }

  void loadInt(String key) async {
    setState(() {
      switch (key) {
        case 'userBirthday':
          int x = prefs.get(key) ?? 0;
          int day = (x % 100);
          x = (x / 100).round();
          int month = (x % 100);
          x = (x / 100).round();
          this.age = new DateTime(x, month, day);
          print(this.age);
          break;
        case 'userSize':
          this.userSize = prefs.get(key) ?? "No Data";
          break;
        case 'userTrainingDays':
          this.userTrainingDays = prefs.get(key) ?? 0;
          break;
      }
    });
  }

  Future<Null> setDouble(String key, double w) async {
    await this.prefs.setDouble(key, w);
    print("Double saved");
  }

  void loadDouble(String key) async {
    setState(() {
      this.weight = prefs.get(key) ?? "No Data";
    });
  }

  Future<Null> setString(String key, String g) async {
    await this.prefs.setString(key, g);
    print("String saved");
  }

  void loadString(String key) async {
    setState(() {
      print("Get data");
      switch (key) {
        case 'userName':
          this.userName = prefs.get(key) ?? "No Data";
          break;
        case 'userEmail':
          this.email = prefs.get(key) ?? "No Data";
          break;
        case 'userGender':
          this.gender = prefs.get(key) ?? "No Data";
          break;
      }
    });
  }

  Future<bool> backButtonOverride() {
    setState(() {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

/*
  WillPopScope(
        onWillPop: backButtonOverride,
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.green,
          child:
   */
}
