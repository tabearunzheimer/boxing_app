import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:uebung02/helper/Technique.dart';
import 'package:uebung02/helper/techniques_database_helper.dart';
import 'package:uebung02/screens/reusable_widgets.dart';
import 'package:uebung02/screens/technique_details_screen.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;

class DiaryScreen extends StatefulWidget {
  @override
  _DiaryScreenState createState() => new _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  int selectedIndex = 1;
  ReusableWidgets _reusableWidgets;
  DateTime _currentDate;
  List<Technique> learnedTechniques;
  List<Technique> notLearnedTechniques;
  int learnedTechniquesCounter;

  final dbHelper = TechniquesDatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    this._currentDate = DateTime.now();
    print("init");
    createList();
    learnedTechniquesCounter = 0;
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
        _buildContainerForTechniques(index),
      ],
    );
  }

  Widget _buildContainerForTechniques(int index) {
    int anzahlListenElemente = 1;
    try {
      if (index == 0) {
        anzahlListenElemente = this.learnedTechniquesCounter;
        anzahlListenElemente = (this.learnedTechniquesCounter == 0) ? 1 : this.learnedTechniquesCounter;
        //print("Laenge: ${this.techniques.length}");
      }
      if (index == 1) {
        anzahlListenElemente = this.notLearnedTechniques.length;
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
                  return buildWorkouts(); //vergangene Workout-Liste
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
        //headerText: getMonthName(),
        selectedDateTime: this._currentDate,
        onDayPressed: (DateTime date, List<Event> events) {
          this.setState(() => this._currentDate = date);
        },
        //markedDatesMap: ,  //gibt die Trainingstage an
      ),
    );
  }

  Widget buildStatistics() {
    return null;
  }

  Widget buildWorkouts() {
    return null;
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
            onPressed: null,
          ),
          IconButton(
            icon: this.learnedTechniques[index].getLearnedIcon(),
            onPressed: (){
              setState(() {
                this.learnedTechniquesCounter--;
                this.learnedTechniques[index].learned = false;
                updateDatabaseEntry(this.learnedTechniques[index]);
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
            onPressed: null,
          ),
          IconButton(
            icon: this.notLearnedTechniques[index].getLearnedIcon(),
            onPressed: (){
              print("Pressed");
              setState(() {
                this.notLearnedTechniques[index].learned = true;
                print("learned: ${this.notLearnedTechniques[index].id} ${this.notLearnedTechniques[index].name}");
                updateDatabaseEntry(this.notLearnedTechniques[index]);
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

  void insertDatabaseEntry(Map<String, dynamic> row) async {
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  void query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  void updateDatabaseEntry(Technique t) async {
    Map<String, dynamic> row = {
      TechniquesDatabaseHelper.columnId: t.id,
      TechniquesDatabaseHelper.columnName: t.name,
      TechniquesDatabaseHelper.columnAudio: 'weg',
      TechniquesDatabaseHelper.columnLink: t.getLink(),
      TechniquesDatabaseHelper.columnExplanation: t.getErklaerung(),
      TechniquesDatabaseHelper.columnType: t.getType(),
      TechniquesDatabaseHelper.columnLearned: t.getLearned(),
      TechniquesDatabaseHelper.columnLastTrainedDay: t.getDay(),
      TechniquesDatabaseHelper.columnLastTrainedMonth: t.getMonth(),
      TechniquesDatabaseHelper.columnLastTrainedYear: t.getYear(),
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void deleteDatabaseEntry(String name) async {
    // Assuming that the number of rows is the id for the last row.
    //final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(name);
    print('deleted $rowsDeleted row(s): row $name');
  }

  void createList() async {
    List l;
    print("Create List");
    final allRows = await dbHelper.queryAllRows();
    final techniqueListLength = await dbHelper.queryRowCount();
    //final allRows = await dbHelper.queryAllRows();
    l = allRows.toList();
    print("Liste: ${l.length}");
    print("TechniqueListLength: ${techniqueListLength}");
    List<Technique> learned = new List();
    List<Technique> notlearned = new List();
    for (int i = 0; i < techniqueListLength; i++) {
      //print("ID ${l[i]}");
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

}
