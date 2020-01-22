import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uebung02/helper/date_helper.dart';
import 'package:uebung02/helper/validator.dart';
import 'package:uebung02/screens/reusable_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

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
  File _imageFile;
  TextEditingController _nametext =  new TextEditingController();
  TextEditingController _weightTextController =  new TextEditingController();
  TextEditingController _sizeTextController =  new TextEditingController();
  TextEditingController _dayPerWeekTextController =  new TextEditingController();
  TextEditingController _yearTextController =  new TextEditingController();
  TextEditingController _monthTextController =  new TextEditingController();
  TextEditingController _dayTextController =  new TextEditingController();

  static const String userWeightKey = 'userWeight';
  static const String userGenderKey = 'userGender';
  static const String userSizeKey = 'userSize';
  static const String userNameKey = 'userName';
  static const String userEmailKey = 'userEmail';
  static const String userBirthdayKey = 'userBirthday';
  static const String trainingDaysKey = 'userTrainingDays';
  static const String userProfilePicKey = 'userProfilePic';

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
      loadString(userProfilePicKey);
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
                        onPressed: (){
                          showDialog<String> (
                            context: context,
                            builder: (BuildContext context) => SimpleDialog(
                              title: Text("Gib deinen Namen ein"),
                              elevation: 1,
                              contentPadding: EdgeInsets.all(10),
                              children: <Widget>[
                                TextField(
                                  controller: _nametext,
                                ),
                                FlatButton(
                                    child: Text("Speichern"),
                                  onPressed: (){
                                    setString(userNameKey, _nametext.text);
                                    setState(() {
                                      this.userName = _nametext.text;
                                    });
                                      Navigator.pop(context);
                                  }
                                ),
                              ],
                            ),
                          );
                        },
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
                        width: 190.0,
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
                          onPressed: (){
                            showDialog<String> (
                              context: context,
                              builder: (BuildContext context) => SimpleDialog(
                                title: Text("Wähle dein Geschlecht"),
                                elevation: 1,
                                contentPadding: EdgeInsets.all(10),
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      RaisedButton(
                                        child: Text("Weiblich",
                                            style: Theme.of(context).textTheme.body2),
                                          onPressed: (){
                                            setState(() {
                                              setString(userGenderKey, "Weiblich");
                                              this.gender = "Weiblich";
                                            });
                                            Navigator.pop(context);
                                          },
                                      ),
                                      RaisedButton(
                                        child: Text(
                                          "Männlich",
                                          style: Theme.of(context).textTheme.body2,),
                                        onPressed: (){
                                          setState(() {
                                            setString(userGenderKey, "Männlich");
                                            this.gender = "Männlich";
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        width: 190.0,
                        height: 50.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Color.fromRGBO(200, 0, 0, 1),
                          disabledColor: Color.fromRGBO(200, 0, 0, 1),
                          child: Text(
                            this.age.day == null ? "Keine Daten" : "${this.age.day}\. ${datehelper.getMonthName(this.age.month)} ${this.age.year}",
                            style: Theme.of(context).textTheme.body1,
                          ),
                          onPressed: (){
                            showDialog<String>(
                                context: context,
                              builder: (BuildContext context) => SimpleDialog(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Text("Tag", style: Theme.of(context).textTheme.body2),
                                          Container(
                                            width: 50,
                                            height: 30,
                                            child: TextField(
                                              controller: _dayTextController,
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
                                              controller: _monthTextController,
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
                                              controller: _yearTextController,
                                              decoration: new InputDecoration(),
                                              keyboardType: TextInputType.numberWithOptions(
                                                  decimal: false, signed: true),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  FlatButton(
                                      child: Text("Speichern"),
                                      onPressed: (){
                                        int year = int.parse(_yearTextController.text);
                                        int month = int.parse(_monthTextController.text);
                                        int day = int.parse(_dayTextController.text);
                                        int birthday = year*10000 + month*100 + day;

                                        Validator v = new Validator();

                                        if (v.validateYear(year) && v.validateDay(day, month) && v.validateMonth(month)){
                                          setState(() {
                                            setInt(userBirthdayKey, birthday);
                                            this.age = new DateTime(year, month, day);
                                          });
                                          Navigator.pop(context);
                                        }
                                      }
                                  ),
                                ],
                              )
                            );
                          },
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
                        width: 190.0,
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
                          onPressed: (){
                            showDialog<String> (
                              context: context,
                              builder: (BuildContext context) => SimpleDialog(
                                title: Text("Gib dein Gewicht ein"),
                                elevation: 1,
                                contentPadding: EdgeInsets.all(10),
                                children: <Widget>[
                                Container(
                                  width: 50,
                                  child: TextField(
                                    controller: _weightTextController,
                                    decoration: new InputDecoration(),
                                    keyboardType: TextInputType.numberWithOptions(
                                        decimal: true, signed: true),
                                  ),
                                ),
                                  FlatButton(
                                      child: Text("Speichern"),
                                      onPressed: (){
                                        Validator v = new Validator();

                                        if (v.validateWeight(double.parse( _weightTextController.text))){
                                          setState(() {
                                            setDouble(userWeightKey, double.parse( _weightTextController.text));
                                            this.weight = double.parse( _weightTextController.text);
                                          });
                                          Navigator.pop(context);
                                        }
                                      }
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        width: 190.0,
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
                          onPressed: (){
                            showDialog<String> (
                              context: context,
                              builder: (BuildContext context) => SimpleDialog(
                                title: Text("Gib deine Größe ein"),
                                elevation: 1,
                                contentPadding: EdgeInsets.all(10),
                                children: <Widget>[
                                  TextField(
                                    controller: _sizeTextController,
                                    decoration: new InputDecoration(),
                                    keyboardType: TextInputType.numberWithOptions(
                                        decimal: false, signed: true),
                                  ),
                                  FlatButton(
                                      child: Text("Speichern"),
                                      onPressed: (){
                                        Validator v = new Validator();

                                        if (v.validateSize(int.parse( _sizeTextController.text))){
                                          setState(() {
                                            setInt(userSizeKey, int.parse( _sizeTextController.text));
                                            this.userSize = int.parse( _sizeTextController.text);
                                          });
                                          Navigator.pop(context);
                                        }
                                      }
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 20, 5, 20),
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Color.fromRGBO(200, 0, 0, 1),
                      disabledColor: Color.fromRGBO(200, 0, 0, 1),
                      child: Text(
                        "Trainingstage pro Woche: ${this.userTrainingDays}",
                        style: Theme.of(context).textTheme.body1,
                      ),
                      onPressed: (){
                        showDialog<String> (
                          context: context,
                          builder: (BuildContext context) => SimpleDialog(
                            title: Text("Gib die Anzahl der Tage ein, an denen du trainieren möchtest"),
                            elevation: 1,
                            contentPadding: EdgeInsets.all(10),
                            children: <Widget>[
                              TextField(
                                controller: _dayPerWeekTextController,
                                decoration: new InputDecoration(),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: false, signed: true),
                              ),
                              FlatButton(
                                  child: Text("Speichern"),
                                  onPressed: (){
                                    Validator v = new Validator();

                                    if(v.validateDaysPerWeek( int.parse( _dayPerWeekTextController.text))){
                                      setState(() {
                                        setInt(trainingDaysKey, int.parse( _dayPerWeekTextController.text));
                                        this.userTrainingDays = int.parse( _dayPerWeekTextController.text);
                                      });
                                      Navigator.pop(context);
                                    }
                                  }
                              ),
                            ],
                          ),
                        );
                      },
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

  ///returns the user picture
  Widget buildUserPicture() {
    return Container(
      height: (MediaQuery.of(context).size.height / 3.5),
      width: (MediaQuery.of(context).size.width),
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: _imageFile == null ? Image.asset("assets/img/female_fighter_punch.jpg", fit: BoxFit.fitWidth,) : Image.file(this._imageFile, fit: BoxFit.fitWidth,),
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
                onPressed: getImage,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///lets the user pick an image from the file system and saves it as a new profile picture
  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    final doc = await getApplicationDocumentsDirectory();
    String path = doc.path;

    final File newImage = await image.copy('$path/image1.jpg');
    print(newImage.path);
    setString(userProfilePicKey, newImage.path);

    setState(() {
      _imageFile = newImage;
    });
  }

  ///saves an integer with shared preferences
  Future<Null> setInt(String key, int w) async {
    await this.prefs.setInt(key, w);
    print("Int saved");
  }

  ///loads an integer with shared preferences
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
          this.userSize = prefs.get(key) ?? 0;
          break;
        case 'userTrainingDays':
          this.userTrainingDays = prefs.get(key) ?? 0;
          break;
      }
    });
  }

  ///saves a double with shared preferences
  Future<Null> setDouble(String key, double w) async {
    await this.prefs.setDouble(key, w);
    print("Double saved");
  }

  ///loads an double with shared preferences
  void loadDouble(String key) async {
    setState(() {
      this.weight = prefs.get(key) ?? 0;
    });
  }

  ///saves a string with shared preferences
  Future<Null> setString(String key, String g) async {
    await this.prefs.setString(key, g);
    print("String saved");
  }

  ///loads a string with shared preferences
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
        case 'userProfilePic':
          print("load pic");
          this._imageFile = new File(prefs.get(key));
          break;
      }
    });
  }

  ///when the back button is pressed the user is navigated to the home screen
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
