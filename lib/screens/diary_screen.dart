import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
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
  int selectedIndex = 1;
  ReusableWidgets _reusableWidgets;
  DateTime _currentDate;
  List<Technique> learnedTechniques;
  List<Technique> notLearnedTechniques;
  EventList<Event> trainingDays;
  List<Workout> workoutList;
  int learnedTechniquesCounter;
  int workoutCounter;
  DateHelper datehelper;
  AnimationController controller;
  double posx = 100.0;
  bool tapInProgress;

  final dbHelperTechniques = TechniquesDatabaseHelper.instance;
  final dbHelperWorkouts = WorkoutDatabaseHelper.instance;

  List<int> testwerte = [1,5,7,2,11,9,4,3,14,10,0,6];
  List<String> testWerteX = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];

  @override
  void initState() {
    super.initState();
    this._currentDate = DateTime.now();
    print("init");
    datehelper = new DateHelper();
    learnedTechniquesCounter = 0;
    workoutCounter = 0;
    this.trainingDays = new EventList();
    createTechniquesList();
    createWorkoutsList();
    this.controller = AnimationController(
      vsync: this,
    );
    this.tapInProgress = false;
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    this._reusableWidgets = new ReusableWidgets(context, selectedIndex);
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

  Widget _buildExpansionTile(List<Object> ll, int index) {
    return ExpansionTile(
      title: Text(ll[index]),
      children: <Widget>[
        _buildContainer(index),
      ],
    );
  }

  Widget _buildContainer(int index) {
    int anzahlListenElemente = 1;
    try {
      switch(index){
        case 0:
          anzahlListenElemente = this.learnedTechniquesCounter;
          anzahlListenElemente = (this.learnedTechniquesCounter == 0) ? 1 : this.learnedTechniquesCounter;
          break;
        case 1:
          anzahlListenElemente = this.notLearnedTechniques.length;
          break;
        case 2:
          anzahlListenElemente = (this.workoutCounter == 0) ? 1 : this.workoutCounter;
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
                  if (this.learnedTechniquesCounter == 0){
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
                  if (this.workoutCounter == 0){
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
        markedDatesMap: trainingDays,  //gibt die Trainingstage an
        markedDateWidget: Container(color: Colors.black, height: 4.0, width: 4.0, margin: EdgeInsets.only(right: 1),),
      ),
    );
  }

  //TODO Platzhalter entfernen
  Widget buildStatistics() {
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
                Text("Technik 1", style: Theme.of(context).textTheme.body2,),
                Text("Technik 2", style: Theme.of(context).textTheme.body2,),
                Text("Technik 3", style: Theme.of(context).textTheme.body2,),
                Text("Technik 4", style: Theme.of(context).textTheme.body2,),
                Text("Technik 5", style: Theme.of(context).textTheme.body2,),
              ],
            ),
          ),
          Divider(
            color: Colors.black54,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text("Lange nicht trainierte Techniken", style: TextStyle(fontSize: 20, color: Colors.black),),
          ),
          Divider(
            color: Colors.black54,
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Technik 1", style: Theme.of(context).textTheme.body2,),
                Text("Technik 2", style: Theme.of(context).textTheme.body2,),
                Text("Technik 3", style: Theme.of(context).textTheme.body2,),
                Text("Technik 4", style: Theme.of(context).textTheme.body2,),
                Text("Technik 5", style: Theme.of(context).textTheme.body2,),
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
                //TODO ANIMATION
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
                      animation: this.controller,
                      builder: (BuildContext context, Widget child) {
                        return CustomPaint(
                          painter: CustomStatisticPainter(
                            animation: this.controller,
                            backgroundColor: Colors.white,
                            color: Theme.of(context).accentColor,
                            posX: this.posx,
                            anzahlWerteX: this.testWerteX.length,
                            werteY: testwerte,
                            werteX: this.testWerteX
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: AnimatedBuilder(
                    animation: controller,
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

  Widget _buildWorkoutListItems(int index){
    print("index ${index}");
    return ListTile(
      title: Text("${this.workoutList[index].getType()}"),
      subtitle: Text("Datum: ${this.workoutList[index].getDateTimeString()}", style: TextStyle(fontSize: 15.0),),
      trailing: Text("${this.workoutList[index].getDuration()} min", style: Theme.of(context).textTheme.body2,),
      onTap: null,
    );
  }

  Widget _buildLearnedTechniqueListItems(int index) {
    return ListTile(
      dense: true,
      leading: this.learnedTechniques[index].getTypeIcon(),
      title: Text(
        this.learnedTechniques[index].name,
        style: TextStyle(fontSize: 15.0),
      ),
      subtitle: Text("Datum: ${this.learnedTechniques[index].getLastTrained()}"),
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
                this.learnedTechniques[index].speak();
            },
          ),
          IconButton(
            icon: this.learnedTechniques[index].getLearnedIcon(),
            onPressed: (){
              setState(() {
                this.learnedTechniquesCounter--;
                this.learnedTechniques[index].learned = false;
                updateTechniquesDatabaseEntry(this.learnedTechniques[index]);
                this.notLearnedTechniques.add(this.learnedTechniques[index]);
                this.learnedTechniques.removeAt(index);
              });
            },
          ),
        ],
      ),
      //oeffne Infos zum Kick
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TechniqueDetailsScreen(this.learnedTechniques[index])));
      },
    );
  }

  Widget _buildNotLearnedTechniqueListItems(int index) {
    return ListTile(
      dense: true,
      leading: this.notLearnedTechniques[index].getTypeIcon(),
      title: Text(
        this.notLearnedTechniques[index].name,
        style: TextStyle(fontSize: 15.0),
      ),
      subtitle: Text("Datum: ${this.notLearnedTechniques[index].getLastTrained()}"),
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
              this.notLearnedTechniques[index].speak();
            },
          ),
          IconButton(
            icon: this.notLearnedTechniques[index].getLearnedIcon(),
            onPressed: (){
              print("Pressed");
              setState(() {
                this.notLearnedTechniques[index].learned = true;
                print("learned: ${this.notLearnedTechniques[index].id} ${this.notLearnedTechniques[index].name}");
                updateTechniquesDatabaseEntry(this.notLearnedTechniques[index]);
                this.learnedTechniques.add(this.notLearnedTechniques[index]);
                this.learnedTechniquesCounter++;
                this.notLearnedTechniques.removeAt(index);
              });
            },
          ),
        ],
      ),
      //oeffne Infos zum Kick
      onTap: () {
        Technique t = this.notLearnedTechniques[index];
        print(t.getName());
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TechniqueDetailsScreen(t)));
      },
    );
  }

  Future<bool> backButtonOverride() {
    setState(() {
      Navigator.pushReplacementNamed(context, '/home');
    });
    return Future.value(true);
  }

  void query() async {
    final allRows = await dbHelperTechniques.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  void updateTechniquesDatabaseEntry(Technique t) async {
    Map<String, dynamic> row = {
      TechniquesDatabaseHelper.columnId: t.id,
      TechniquesDatabaseHelper.columnName: t.name,
      TechniquesDatabaseHelper.columnLink: t.getLink(),
      TechniquesDatabaseHelper.columnExplanation: t.getErklaerung(),
      TechniquesDatabaseHelper.columnType: t.getType(),
      TechniquesDatabaseHelper.columnLearned: t.getLearned(),
      TechniquesDatabaseHelper.columnLastTrainedDay: t.getDay(),
      TechniquesDatabaseHelper.columnLastTrainedMonth: t.getMonth(),
      TechniquesDatabaseHelper.columnLastTrainedYear: t.getYear(),
    };
    final rowsAffected = await dbHelperTechniques.update(row);
    print('updated $rowsAffected row(s)');
  }

  void createTechniquesList() async {
    List l;
    print("Create List");
    final allRows = await dbHelperTechniques.queryAllRows();
    final techniqueListLength = await dbHelperTechniques.queryRowCount();
    //final allRows = await dbHelper.queryAllRows();
    l = allRows.toList();
    print("Liste: ${l.length}");
    print("TechniqueListLength: ${techniqueListLength}");
    List<Technique> learned = new List();
    List<Technique> notlearned = new List();

    for (int i = 0; i < techniqueListLength; i++) {
      //print("${l[0]}");
      Technique t = new Technique.fromJson(l.removeAt(0));
      print("ID: ${t.id}");
      if (t.learned){
        learned.add(t);
        learnedTechniquesCounter++;
      } else {
        notlearned.add(t);
      }
    }
    //print(list[2].name);
    setState(() {
      this.learnedTechniques = learned;
      this.notLearnedTechniques = notlearned;
      print("Liste uebergeben, laenge: ${notLearnedTechniques.length}");
    });
  }

  void createWorkoutsList() async{
    List l;
    print("Create Workout List");
    final allRows = await dbHelperWorkouts.queryAllRows();
    l = allRows.toList();
    List<Workout> erg = new List();
    EventList<Event> ev = new EventList();
    print("Workout Liste: ${l.length}");
    int x = l.length;
    for (int i = 0; i < x; i++) {
      print(l[i].toString());
      Workout w = new Workout.fromJson(l[i]);
      erg.add(w);
      ev.add(w.getDateTime(), Event(date: w.getDateTime(), title: w.getType()));
    }


    setState(() {
      this.workoutList = erg;
      this.workoutCounter = x;
      this.trainingDays = ev;
      print("Workout-Liste uebergeben, laenge: ${this.workoutList.length}");
    });
  }


  void dragStart(BuildContext context, DragStartDetails details) {
    //print('Start: ${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);

    setState(() {
      posx = localOffset.dx;
      this.tapInProgress = true;
    });
  }

  dragDown(BuildContext context, DragDownDetails details) {
    //print('Ende: ${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);

    setState(() {
      posx = localOffset.dx;
      this.tapInProgress = true;
    });
  }

  void dragUpdate(BuildContext context, DragUpdateDetails details) {
    //print('${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);

    setState(() {
      posx = localOffset.dx;
      this.controller.value = localOffset.dx;
      this.tapInProgress = true;
    });
  }

  String getCurrentInput() {
    int index = 0;
    double alt = 0;
    for (double i = 50; i < MediaQuery.of(context).size.width && index < this.testWerteX.length; i = i + (MediaQuery.of(context).size.width - 60) / this.testWerteX.length) {
      if (this.posx <= i && this.posx >= alt) {
        return "${this.testWerteX[index]}: ${this.testwerte[index]} Trainings";
      }
      alt = i;
      index++;
      index = index > 11 ? 11 : index;
    }
  }


}