import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:sqflite/sqflite.dart';
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
  List<Technique> techniques;

  final dbHelper = TechniquesDatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    this._currentDate = DateTime.now();
    createList();
    try {
      dbHelper.insertList();
    } catch (e) {
      print("Fehler: $e");
    }
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
    //List<String> techniques = ["Eins", "Zwei", "Drei", "Vier", "Fünf", "Sechs", "..."];

    //query();

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
    List<Technique> learned;
    List<Technique> notlearned;
    try {
      if (index < 2) {
        anzahlListenElemente = this.techniques.length;
        print("Laenge: ${this.techniques.length}");
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
                  return _buildTechniqueListItems(indexZwei);
                  break;
                case 1:
                  return _buildTechniqueListItems(indexZwei);
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

  String getMonthName() {
    String erg = "";
    switch (this._currentDate.month) {
      case 0:
        erg = "Januar";
        break;
      case 1:
        erg = "Februar";
        break;
      case 2:
        erg = "März";
        break;
      case 3:
        erg = "April";
        break;
      case 4:
        erg = "Mai";
        break;
      case 5:
        erg = "Juni";
        break;
      case 6:
        erg = "Juli";
        break;
      case 7:
        erg = "August";
        break;
      case 8:
        erg = "September";
        break;
      case 9:
        erg = "Oktober";
        break;
      case 11:
        erg = "November";
        break;
      case 12:
        erg = "Dezemeber";
        break;
    }
    return erg;
  }

  Widget buildStatistics() {
    return null;
  }

  Widget buildWorkouts() {
    return null;
  }

  Widget _buildTechniqueListItems(int index) {
    return ListTile(
      dense: true,
      leading: this.techniques[index].getTypeIcon(),
      title: Text(
        this.techniques[index].name,
        style: TextStyle(fontSize: 15.0),
      ),
      subtitle: Text("Datum: ${this.techniques[index].getLastTrained()}"),
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
            icon: this.techniques[index].getLearnedIcon(),
            onPressed: null,
          ),
        ],
      ),
      //oeffne Infos zum Kick
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TechniqueDetailsScreen()));
      },
    );
  }

  Future<bool> backButtonOverride() {
    setState(() {
      Navigator.pushReplacementNamed(context, '/home');
      return true;
    });
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

  void updateDatabaseEntry(Map<String, dynamic> row) async {
    // row to update
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void deleteDatabaseEntry(String name) async {
    // Assuming that the number of rows is the id for the last row.
    //final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(name);
    print('deleted $rowsDeleted row(s): row $name');
  }

  Future<int> createList() async {
    List l;
    final allRows = await dbHelper.queryAllRows();
    final techniqueListLength = await dbHelper.queryRowCount();
    //final allRows = await dbHelper.queryAllRows();
    l = allRows.toList();
    //print("Liste: ${l.length}");
    //print("TechniqueListLength: ${techniqueListLength}");
    List<Technique> list = new List();
    for (int i = 0; i < techniqueListLength; i++) {
      //print("Remove ${l[0]}");
      Technique t = new Technique.fromJson(l.removeAt(0));
      list.add(t);
    }
    //print(list[2].name);
    setState(() {
      this.techniques = list;
      print("Liste uebergeben, laenge: ${techniques.length}");
    });
    return Future.value(0);
  }

  List<List<Technique>> differentiateList(){
    List<Technique> learned;
    List<Technique> notlearned;
    for (int i = 0; i < this.techniques.length; i++){
      if (this.techniques[i].learned){
        learned.add(this.techniques[i]);
      } else {
        notlearned.add(this.techniques[i]);
      }
    }
    List<List> l;
    l.add(learned);
    l.add(notlearned);
    return l;
  }

}
