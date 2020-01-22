import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uebung02/helper/CustomStatisticsPainter.dart';
import 'package:uebung02/helper/Technique.dart';
import 'package:uebung02/helper/Workout.dart';
import 'package:uebung02/helper/date_helper.dart';
import 'package:uebung02/helper/techniques_database_helper.dart';
import 'package:uebung02/helper/workout_database_helper.dart';
import 'package:uebung02/screens/reusable_widgets.dart';
import 'package:uebung02/screens/technique_details_screen.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'

    show CalendarCarousel, EventList;

class DiaryScreen extends StatefulWidget {
  @override
  _DiaryScreenState createState() => new _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 1;
  ReusableWidgets _reusableWidgets;
  SharedPreferences _prefs;
  DateTime _currentDate;
  List<Technique> _learnedTechniques;
  List<Technique> _notLearnedTechniques;
  EventList<Event> _trainingDays;
  List<Workout> _workoutList;
  int _learnedTechniquesCounter;
  int _workoutCounter;
  DateHelper _datehelper;
  AnimationController _controller;
  double _posx = 100.0;
  bool _tapInProgress;

  final _dbHelperTechniques = TechniquesDatabaseHelper.instance;
  final _dbHelperWorkouts = WorkoutDatabaseHelper.instance;

  List<int> _yValues = [0,0,0,0,0,0,0,0,0,0,0,0];
  List<String> _months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];

  @override
  void initState() {
    super.initState();
    this._currentDate = DateTime.now();
    print("init");
    _datehelper = new DateHelper();
    _learnedTechniquesCounter = 0;
    _workoutCounter = 0;
    this._trainingDays = new EventList();
    createTechniquesList();
    createWorkoutsList();
    this._controller = AnimationController(
      vsync: this,
    );
    this._tapInProgress = false;
    SharedPreferences.getInstance().then((sp) {
      this._prefs = sp;
    });

  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    this._reusableWidgets = new ReusableWidgets(context, _selectedIndex);
    List<String> ll = [
      "Erlernte Techniken",
      "Zu lernende Techniken",
      "Workouts",
      "Statistiken",
      "Kalender"
    ];

    return new Scaffold(
      appBar: this._reusableWidgets.getAppBar(),
      body: WillPopScope(
        onWillPop: backButtonOverride,
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Color.fromRGBO(0, 0, 0, 0.8),
          ),
          itemCount: ll.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return _buildExpansionTile(ll, index);
          },
        ),
      ),
      bottomNavigationBar: this._reusableWidgets.getBottomNavigataionBar(),
    );
  }

  ///returns an expansion tile containing a container
  Widget _buildExpansionTile(List<Object> ll, int index) {
    return ExpansionTile(
      title: Text(ll[index]),
      children: <Widget>[
        _buildContainer(index),
      ],
    );
  }

  ///returns a container with a given height
  ///contains different lists (learned techniques, not learned techniques, statistics and calendar)
  Widget _buildContainer(int index) {
    int anzahlListenElemente = 1;
    try {
      switch(index){
        case 0:
          anzahlListenElemente = this._learnedTechniquesCounter;
          anzahlListenElemente = (this._learnedTechniquesCounter == 0) ? 1 : this._learnedTechniquesCounter;
          break;
        case 1:
          anzahlListenElemente = this._notLearnedTechniques.length;
          break;
        case 2:
          anzahlListenElemente = (this._workoutCounter == 0) ? 1 : this._workoutCounter;
      }
    } catch (e) {
      print(e);
    }
    Container c = new Container(
        height: 500,
        child: ListView.builder(
            itemCount: anzahlListenElemente,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int indexZwei) {
              //return _buildTechniqueListItems(indexZwei);
              switch (index) {
                case 0:
                  if (this._learnedTechniquesCounter == 0){
                    return Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text("Keine erlernten Techniken", style: Theme.of(context).textTheme.body2,),
                    );
                  } else {
                    return _buildLearnedTechniqueListItems(indexZwei);
                  }
                  break;
                case 1:
                  return _buildNotLearnedTechniqueListItems(indexZwei);
                  break;
                case 2:
                  if (this._workoutCounter == 0){
                    return Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text("Keine gespeicherten Workouts", style: Theme.of(context).textTheme.body2,),
                    );
                  } else {
                    return _buildWorkoutListItems(indexZwei);
                  }
                  break;
                case 3:
                  return buildStatistics(); //Statistiken
                  break;
                case 4:
                  return buildCalender(); //Kalender
                  break;
                default:
                  return Container(
                    child: Text(
                      "Fehler",
                      style: Theme.of(context).textTheme.body2,
                    ),
                  );
              }
            }
            )
    );
    return c;
  }

  ///returns a calendar
  Widget buildCalender() {
    print("Haha");
    return SingleChildScrollView(
      child: CalendarCarousel<Event>(
        thisMonthDayBorderColor: Colors.grey,
        height: 420.0,
        daysHaveCircularBorder: null,

        /// null for not rendering any border, true for circular border, false for rectangular border
        headerTextStyle: Theme.of(context).textTheme.display2,
        firstDayOfWeek: DateTime.monday,
        iconColor: Color.fromRGBO(0, 0, 0, 1),
        selectedDayButtonColor: Color.fromRGBO(200, 0, 0, 1),
        selectedDayTextStyle: Theme.of(context).textTheme.display1,
        todayButtonColor: Color.fromRGBO(255, 255, 255, 0),
        todayTextStyle: TextStyle(color: Colors.black, fontSize: 18),
        weekendTextStyle: TextStyle(color: Color.fromRGBO(200, 0, 0, 1),),
        selectedDateTime: this._currentDate,
        onDayPressed: (DateTime date, List<Event> events) {
          this.setState(() => this._currentDate = date);
        },
        markedDatesMap: _trainingDays,  //gibt die Trainingstage an
        markedDateWidget: Container(color: Colors.black, height: 4.0, width: 4.0, margin: EdgeInsets.only(right: 1),),
      ),
    );
  }


  ///returns different statistics
  Widget buildStatistics() {
    List <String> techniken = new List();
    int z = 0;
    for (int i = 0; i < _workoutList.length; i++){
      print(_workoutList[i].getTechniques());
      if (_workoutList[i].getTechniques().length > 2){
        print("hinzufügen");
        List<String> zw = _workoutList[i].separateTechniques();
        for (int j = 0; j < zw.length; j++){
          if (z < 5){
            techniken.add(zw[j]);
            print(techniken[j]);
            z++;
          }
        }
      }
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text("Zuletzt trainierte Techniken", style: TextStyle(fontSize: 20, color: Colors.black),),
          ),
          Divider(
            color: Colors.black54,
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                techniken.length == 0 ? Text("Keine Techniken vorhanden", style: Theme.of(context).textTheme.body2,) : Text(techniken[0], style: Theme.of(context).textTheme.body2,),
                techniken.length <= 1 ? Text("Keine Technik vorhanden", style: Theme.of(context).textTheme.body2,) : Text(techniken[1], style: Theme.of(context).textTheme.body2,),
                techniken.length <= 2 ? Text("Keine Technik vorhanden", style: Theme.of(context).textTheme.body2,) : Text(techniken[2], style: Theme.of(context).textTheme.body2,),
                techniken.length <= 3 ? Text("Keine Technik vorhanden", style: Theme.of(context).textTheme.body2,) : Text(techniken[3], style: Theme.of(context).textTheme.body2,),
                techniken.length <= 4 ? Text("Keine Technik vorhanden", style: Theme.of(context).textTheme.body2,) : Text(techniken[4], style: Theme.of(context).textTheme.body2,),
              ],
            ),
          ),
          Divider(
            color: Colors.black54,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text("Trainings pro Monat", style: TextStyle(fontSize: 20, color: Colors.black),),
          ),
          Divider(
            color: Colors.black54,
          ),
          Container(
            //color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 320,
                  //margin: EdgeInsets.only(top: 500, bottom: 0),
                  width: MediaQuery.of(context).size.width,
                  child: GestureDetector(
                    onHorizontalDragStart: (DragStartDetails details) =>
                        dragStart(context, details),
                    onHorizontalDragUpdate: (DragUpdateDetails details) =>
                        dragUpdate(context, details),
                    onHorizontalDragDown: (DragDownDetails details) =>
                        dragDown(context, details),
                    child: AnimatedBuilder(
                      animation: this._controller,
                      builder: (BuildContext context, Widget child) {
                        return CustomPaint(
                          painter: CustomStatisticPainter(
                            animation: this._controller,
                            backgroundColor: Colors.white,
                            color: Theme.of(context).accentColor,
                            posX: this._posx,
                            anzahlWerteX: this._months.length,
                            werteY: _yValues,
                            werteX: this._months
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (BuildContext context, Widget child) {
                      return Text(
                        getCurrentInput(),
                        style: Theme.of(context).textTheme.body2,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  ///returns a list containing all workouts
  Widget _buildWorkoutListItems(int index){
    print("index ${index}");
    return ListTile(
      title: Text("${this._workoutList[index].getType()}-Training: ${this._workoutList[index].getDurationAsString()}"),
      subtitle: Text("Datum: ${this._workoutList[index].getDateTimeString()}", style: TextStyle(fontSize: 12.0),),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: (){
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text("Vorsicht!"),
            content: Text("Möchten Sie dieses Workout wirklich löschen?"),
            actions: <Widget>[
              FlatButton(
                child: Text("Löschen"),
                onPressed: (){
                  Navigator.pop(context);
                  _dbHelperWorkouts.delete(this._workoutList[index].getId());

                  setState(() {
                    this._workoutList.removeAt(index);
                    this._workoutCounter--;
                  });
                },
              ),
              FlatButton(
                child: Text("Behalten"),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
      ),
      onTap: (){
        showDialog<String> (
          context: context,
          builder: (BuildContext context) => SimpleDialog(
            title: Text("Workout"),
            elevation: 1,
            contentPadding: EdgeInsets.all(10),
            children: <Widget>[
              Text("Trainingstyp: ${this._workoutList[index].getType()}",style: Theme.of(context).textTheme.body2,),
              Text("Datum: ${this._workoutList[index].getDateTimeString()}",style: Theme.of(context).textTheme.body2,),
              Text("Gesamtdauer: ${this._workoutList[index].getDurationAsString()}",style: Theme.of(context).textTheme.body2,),
              Text("Kcal: ${double.parse(this._workoutList[index].getBurnedCalories().toStringAsFixed(2))}",style: Theme.of(context).textTheme.body2,),
              Text("Techniken: ${this._workoutList[index].getTechniques()}",style: Theme.of(context).textTheme.body2,),
            ],
          ),
        );
      },
    );
  }

  ///returns a list containing all learned techniques
  Widget _buildLearnedTechniqueListItems(int index) {
    return ListTile(
      dense: true,
      leading: this._learnedTechniques[index].getTypeIcon(),
      title: Text(
        this._learnedTechniques[index].getName(),
        style: TextStyle(fontSize: 15.0),
      ),
      subtitle: Text("Datum: ${this._learnedTechniques[index].getLastTrained()}"),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.music_note,
              color: Colors.black,
            ),
            onPressed: (){
                this._learnedTechniques[index].speak();
            },
          ),
          IconButton(
            icon: this._learnedTechniques[index].getLearnedIcon(),
            onPressed: (){
              setState(() {
                this._learnedTechniquesCounter--;
                this._learnedTechniques[index].setLearnedAsBool(false);
                updateTechniquesDatabaseEntry(this._learnedTechniques[index]);
                this._notLearnedTechniques.add(this._learnedTechniques[index]);
                this._learnedTechniques.removeAt(index);
              });
            },
          ),
        ],
      ),
      //oeffne Infos zum Kick
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TechniqueDetailsScreen(this._learnedTechniques[index])));
      },
    );
  }

  ///returns a list containing all not learned techniques
  Widget _buildNotLearnedTechniqueListItems(int index) {
    return ListTile(
      dense: true,
      leading: this._notLearnedTechniques[index].getTypeIcon(),
      title: Text(
        this._notLearnedTechniques[index].getName(),
        style: TextStyle(fontSize: 15.0),
      ),
      subtitle: Text("Datum: ${this._notLearnedTechniques[index].getLastTrained()}"),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.music_note,
              color: Colors.black,
            ),
            onPressed: (){
              this._notLearnedTechniques[index].speak();
            },
          ),
          IconButton(
            icon: this._notLearnedTechniques[index].getLearnedIcon(),
            onPressed: (){
              print("Pressed");
              setState(() {
                this._notLearnedTechniques[index].setLearnedAsBool(true);
                print("learned: ${this._notLearnedTechniques[index].getId()} ${this._notLearnedTechniques[index].getName()}");
                updateTechniquesDatabaseEntry(this._notLearnedTechniques[index]);
                this._learnedTechniques.add(this._notLearnedTechniques[index]);
                this._learnedTechniquesCounter++;
                this._notLearnedTechniques.removeAt(index);
              });
            },
          ),
        ],
      ),
      //oeffne Infos zum Kick
      onTap: () {
        Technique t = this._notLearnedTechniques[index];
        print(t.getName());
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TechniqueDetailsScreen(t)));
      },
    );
  }

  ///returns to the home screen when pressing the back button twice
  Future<bool> backButtonOverride() {
    setState(() {
      Navigator.pushReplacementNamed(context, '/home');
    });
    return Future.value(true);
  }

  ///prints all techniques saved in the database
  void query() async {
    final allRows = await _dbHelperTechniques.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  ///updates on technique in the database
  void updateTechniquesDatabaseEntry(Technique t) async {
    Map<String, dynamic> row = {
      TechniquesDatabaseHelper.columnId: t.getId(),
      TechniquesDatabaseHelper.columnName: t.getName(),
      TechniquesDatabaseHelper.columnLink: t.getLink(),
      TechniquesDatabaseHelper.columnExplanation: t.getErklaerung(),
      TechniquesDatabaseHelper.columnType: t.getType(),
      TechniquesDatabaseHelper.columnLearned: t.getLearned(),
      TechniquesDatabaseHelper.columnLastTrainedDay: t.getDay(),
      TechniquesDatabaseHelper.columnLastTrainedMonth: t.getMonth(),
      TechniquesDatabaseHelper.columnLastTrainedYear: t.getYear(),
    };
    final rowsAffected = await _dbHelperTechniques.update(row);
    print('updated $rowsAffected row(s)');
  }

  ///gets all techniques from the database and saves them in a list
  void createTechniquesList() async {
    List l;
    print("Create List");
    final allRows = await _dbHelperTechniques.queryAllRows();
    final techniqueListLength = await _dbHelperTechniques.queryRowCount();
    //final allRows = await dbHelper.queryAllRows();
    l = allRows.toList();
    print("Liste: ${l.length}");
    print("TechniqueListLength: ${techniqueListLength}");
    List<Technique> learned = new List();
    List<Technique> notlearned = new List();

    for (int i = 0; i < techniqueListLength; i++) {
      //print("${l[0]}");
      Technique t = new Technique.fromJson(l.removeAt(0));
      print("ID: ${t.getId()}");
      if (t.getLearnedAsBool()){
        learned.add(t);
        _learnedTechniquesCounter++;
      } else {
        notlearned.add(t);
      }
    }
    //print(list[2].name);
    setState(() {
      this._learnedTechniques = learned;
      this._notLearnedTechniques = notlearned;
      print("Liste uebergeben, laenge: ${_notLearnedTechniques.length}");
    });
  }

  ///gets all workouts gtom the database and saves them in a list
  void createWorkoutsList() async{
    List l;
    print("Create Workout List");
    final allRows = await _dbHelperWorkouts.queryAllRows();
    l = allRows.toList();
    List<Workout> erg = new List();
    EventList<Event> ev = new EventList();
    print("Workout Liste: ${l.length}");
    int x = l.length;
    for (int i = x-1; i >= 0; i--) {
      print(l[i].toString());
      Workout w = new Workout.fromJson(l[i]);
      erg.add(w);
      ev.add(w.getDateTime(), Event(date: w.getDateTime(), title: w.getType()));
    }


    setState(() {
      this._workoutList = erg;
      this._workoutCounter = x;
      this._trainingDays = ev;
      print("Workout-Liste uebergeben, laenge: ${this._workoutList.length}");
    });

    getTrainingAmountPerMonth();
  }

  ///get the x value for the statistics
  void getTrainingAmountPerMonth() async {
    print("get training amount");
    for (int i = 0; i < this._workoutList.length; i++){
      int m = this._workoutList[i].getDateTime().month-1;
      print("month m");
      print("testwerte v m ${_yValues[m]}");
      setState(() {
        this._yValues[m]++;
      });
    }
  }

  ///loads an int from a shred preference
  Future<int> loadInt(String key) async {
    return _prefs.get(key) ?? 0;
  }

  ///saves the position of a tap
  void dragStart(BuildContext context, DragStartDetails details) {
    //print('Start: ${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);

    setState(() {
      _posx = localOffset.dx;
      this._tapInProgress = true;
    });
  }

  ///saves the position when the tap ends
  dragDown(BuildContext context, DragDownDetails details) {
    //print('Ende: ${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);

    setState(() {
      _posx = localOffset.dx;
      this._tapInProgress = true;
    });
  }

  ///saves the position during a tap
  void dragUpdate(BuildContext context, DragUpdateDetails details) {
    //print('${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);

    setState(() {
      _posx = localOffset.dx;
      this._controller.value = localOffset.dx;
      this._tapInProgress = true;
    });
  }

  ///returns a string containing how often the user trained
  ///used for the statistics
  String getCurrentInput() {

    int index = 0;
    double alt = 0;
    for (double i = 50; i < MediaQuery.of(context).size.width && index < this._months.length; i = i + (MediaQuery.of(context).size.width - 60) / this._months.length) {
      if (this._posx <= i && this._posx >= alt) {
        String month = _datehelper.getMonthName(int.parse(this._months[index]));
        return "$month: ${this._yValues[index]} mal trainiert";
      }
      alt = i;
      index++;
      index = index > 11 ? 11 : index;
    }
    return "";
  }



}