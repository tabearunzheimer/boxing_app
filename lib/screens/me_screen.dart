import 'package:flutter/material.dart';
import 'package:uebung02/screens/reusable_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeScreen extends StatefulWidget {
  @override
  _MeScreenState createState() => new _MeScreenState();
}


class _MeScreenState extends State<MeScreen> {

  SharedPreferences prefs;
  int weight;
  String userName;
  String email;
  DateTime age;
  String gender;
  int userSize;
  int selectedIndex = 2;
  ReusableWidgets _reusableWidgets;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sp){
      this.prefs = sp;
      loadUserWeight();
      loadUserSize();
      loadUserGender();
      loadUserName();
      loadUserEmail();
    });
  }


  @override
  Widget build(BuildContext context) {
    _reusableWidgets = new ReusableWidgets(context, selectedIndex);
    age = new DateTime.utc(1999, DateTime.june, 28);
    /*
    setUserSize(163);
    setUserGender("Weiblich");
    setUserName("Tabea");
    setUserEmail("tabea.runzheimer@informatik.hs-fulda.de");
    */

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: _reusableWidgets.getAppBar(),
      body:
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
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
                              shape: CircleBorder(side: BorderSide(color: Colors.white, width: 1.5)),
                              child: Icon(Icons.camera_alt, color: Colors.white),
                              onPressed: null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: (MediaQuery.of(context).size.height / 2),
                    width: (MediaQuery.of(context).size.width),
                    padding: EdgeInsets.all(10),
                    //color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("$userName", style: Theme.of(context).textTheme.display4,),
                            IconButton(
                              onPressed: null,
                              icon: Icon(Icons.edit),
                            ),
                          ],
                        ),
                        Text("$email", style: Theme.of(context).textTheme.body2,),
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
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                color: Color.fromRGBO(200, 0, 0, 1),
                                disabledColor: Color.fromRGBO(200, 0, 0, 1),
                                child: Text("$gender", style: Theme.of(context).textTheme.body1,),
                                onPressed: null,
                              ),
                            ),
                            Container(
                              width: 180.0,
                              height: 50.0,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                color: Color.fromRGBO(200, 0, 0, 1),
                                disabledColor: Color.fromRGBO(200, 0, 0, 1),
                                child: Text("28. Oktober 1999", style: Theme.of(context).textTheme.body1,),
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
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                color: Color.fromRGBO(200, 0, 0, 1),
                                disabledColor: Color.fromRGBO(200, 0, 0, 1),
                                child: Text("$weight kg", style: Theme.of(context).textTheme.body1,),
                                onPressed: null,
                              ),
                            ),
                            Container(
                              width: 180.0,
                              height: 50.0,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                color: Color.fromRGBO(200, 0, 0, 1),
                                disabledColor: Color.fromRGBO(200, 0, 0, 1),
                                child: Text("$userSize cm", style: Theme.of(context).textTheme.body1,),
                                onPressed: null,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text("All sounds and vibrations emanate from that Word. Your voice is a very powerful weapon. When you are in tune with the cosmic breath of heaven and earth, your voice produces true sounds. Unify body, mind and speech, and real techniques will emerge. ~ Morihei Ueshiba (The Art of Peace)",
                          style: Theme.of(context).textTheme.body2,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.9),
      bottomNavigationBar: _reusableWidgets.getBottomNavigataionBar(),
    );
  }

  Future <Null> setUserWeight(int w) async{
    await this.prefs.setInt('userWeight', w);
    print("Weight saved");
  }

  void loadUserWeight() async {
    setState((){
      this.weight = prefs.getInt('userWeight') ?? 0;
    });
  }

  Future <Null> setUserGender(String g) async{
    await this.prefs.setString('userGender', g);
    print("Gender saved");
  }

  void loadUserGender() async {
    setState((){
      this.gender = prefs.get('userGender') ?? "No Data";
    });
  }

  Future <Null> setUserSize(int g) async{
    await this.prefs.setInt('userSize', g);
    print("Usersize saved");
  }

  void loadUserSize() async {
    setState((){
      this.userSize = prefs.get('userSize') ?? 0;
    });
  }

  Future <Null> setUserName(String g) async{
    await this.prefs.setString('userName', g);
    print("Name saved");
  }

  void loadUserName() async {
    setState((){
      this.userName = prefs.get('userName') ?? 0;
    });
  }

  Future <Null> setUserEmail(String g) async{
    await this.prefs.setString('userEmail', g);
    print("Email saved");
  }

  void loadUserEmail() async {
    setState((){
      this.email = prefs.get('userEmail') ?? 0;
    });
  }

}
