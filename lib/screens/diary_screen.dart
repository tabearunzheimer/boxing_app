import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:sqflite/sqflite.dart';
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

  @override
  void initState() {
    super.initState();
    this._currentDate = DateTime.now();
  }


  final dbHelper = TechniquesDatabaseHelper.instance;

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
    List<String> l = ["Eins", "Zwei", "Drei", "Vier", "Fünf", "Sechs", "..."];


    //_insert();
    //_update();
    _query();
    _delete();
    //_query();

    return new Scaffold(
      appBar: this._reusableWidgets.getAppBar(),
      body: WillPopScope(
        onWillPop: backButtonOverride,
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Color.fromRGBO(0, 0, 0, 0.8),
          ),
          itemCount: ll.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return _buildExpansionTile(ll, l, index);
          },
        ),
      ),
      bottomNavigationBar: this._reusableWidgets.getBottomNavigataionBar(),
    );
  }

  Widget _buildExpansionTile(List<Object> ll, List<String> l, int index) {
    int anzahlListenElemente = 1;
    bool addButton = false;
    if (index < 2) {
      anzahlListenElemente = l.length;
    }
    if (index == 1){
      addButton = true;
    }
    return ExpansionTile(
      title: Text(ll[index]),
      children: <Widget>[
        ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Color.fromRGBO(0, 0, 0, 0.2),
          ),
          itemCount: anzahlListenElemente,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int indexZwei) {
            switch (index) {
              case 0:
                return _buildTechniqueListItems(l, indexZwei, addButton);
                break;
              case 1:
                return _buildTechniqueListItems(l, indexZwei, addButton);
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
          },
        ),
      ],
    );
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

  Widget _buildTechniqueListItems(List<Object> l, int index, bool addButton) {
    Icon iconLead = Icon(
        Icons.gps_fixed,
        size: 30.0,
      );
    Icon iconBack;
    if (addButton){
      iconBack  = Icon(Icons.add, color: Colors.black,);
    } else {
      iconBack  = Icon(Icons.remove, color: Colors.black,);
    }

    return ListTile(
      dense: true,
      leading: iconLead,
      title: Text(
        l[index],
        style: TextStyle(fontSize: 15.0),
      ),
      subtitle: Text("Datum: 06.11.2019"),
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
            icon: iconBack,
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
    });
  }

  void _insert() async{
    Map<String, dynamic> row = {
      TechniquesDatabaseHelper.columnName : 'Jab',
      TechniquesDatabaseHelper.columnAudio : 'way',
      TechniquesDatabaseHelper.columnExplaination :  'Lorem Ipsum dolor sit amet',
      TechniquesDatabaseHelper.columnType : 'Offense',
      TechniquesDatabaseHelper.columnLastTrainedDay : 04,
      TechniquesDatabaseHelper.columnLastTrainedMonth : 11,
      TechniquesDatabaseHelper.columnLastTrainedYear : 2019,
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  void _update() async {
    // row to update
    Map<String, dynamic> row = {
      TechniquesDatabaseHelper.columnName : 'Jab',
      TechniquesDatabaseHelper.columnAudio : 'way',
      TechniquesDatabaseHelper.columnExplaination :  'Lorem Ipsum dolor sit amet',
      TechniquesDatabaseHelper.columnType : 'Offense',
      TechniquesDatabaseHelper.columnLastTrainedDay : 04,
      TechniquesDatabaseHelper.columnLastTrainedMonth : 11,
      TechniquesDatabaseHelper.columnLastTrainedYear : 2019,
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
}

