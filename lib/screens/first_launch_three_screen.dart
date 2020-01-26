import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uebung02/helper/Technique.dart';
import 'package:uebung02/helper/techniques_database_helper.dart';
import 'package:uebung02/screens/reusable_widgets.dart';

class FirstLaunchScreenThree extends StatefulWidget {
  @override
  _FirstLaunchScreenThreeState createState() => _FirstLaunchScreenThreeState();
}

class _FirstLaunchScreenThreeState extends State<FirstLaunchScreenThree> {
  List<Technique> learnedTechniques;
  List<bool> _checkBoxVal;
  final dbHelper = TechniquesDatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    this._checkBoxVal = new List();
    this.learnedTechniques = new List();
    createList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Martial Arts Trainer",
        ),
        actions: <Widget>[
          IconButton(
            onPressed: moveToHome,
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Color.fromRGBO(0, 0, 0, 0.8),
        ),
        padding: EdgeInsets.all(10.0),
        shrinkWrap: true,
        itemCount: learnedTechniques.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Text(
              "Wähle die Techniken aus, die du bereits kannst",
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            );
          }
          index -= 1;
          return _buildTechniqueListItems(index);
        },
      ),
    );
  }

  ///returns a scrollable list off all techniques
  Widget _buildTechniqueListItems(int index) {
    return ListTile(
      leading: Checkbox(
        value: _checkBoxVal[index],
        onChanged: (bool value) {
          //print(_checkBoxVal[index]);
          setState(() => this._checkBoxVal[index] = value);
          //print(_checkBoxVal[index]);
        },
      ),
      title: Text(
        this.learnedTechniques[index].getName(),
        style: Theme.of(context).textTheme.display2,
      ),
      subtitle: Text("Datum: ${this.learnedTechniques[index].getLastTrained()}",
        style: Theme.of(context).textTheme.display3,
      ),
      trailing: this.learnedTechniques[index].getTypeIcon(),
      onTap: () {
        this.learnedTechniques[index].getLearnedAsBool() ? this.learnedTechniques[index].setLearnedAsBool(false) : this.learnedTechniques[index].setLearnedAsBool(true);
        if (_checkBoxVal[index]) {
          print("entfernen");
          setState(() {
            _checkBoxVal[index] = false;
          });
        } else {
          setState(() {
            _checkBoxVal[index] = true;
          });
        }
        updateTechniquesDatabaseEntry(this.learnedTechniques[index]);
      },
    );
  }

  ///saves all techniques as a list
  void createList() async {
    List l;
    final allRows = await dbHelper.queryAllRows();
    final techniqueListLength = await dbHelper.queryRowCount();
    l = allRows.toList();
    List<Technique> learned = new List();
    for (int i = 0; i < techniqueListLength; i++) {
      Technique t = new Technique.fromJson(l.removeAt(0));
      learned.add(t);
    }
    setState(() {
      this.learnedTechniques = learned;
      for(int i = 0; i < learned.length; i++){
        this._checkBoxVal.add(false);
      }
      print("Liste uebergeben, laenge: ${learnedTechniques.length}");
    });
  }

  ///shows the next screen
  void moveToHome() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Danke!"),
        content: Text("Du kannst jetzt die App benutzen. Deine Einstellungen kannst du natürlich jederzeit ändern. "),
        actions: <Widget>[
          FlatButton(
            child: Text("App starten"),
            onPressed: (){
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pushNamed(context, '/home');
            },
          ),
          FlatButton(
            child: Text("Abbrechen"),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  ///updates a technique in the database
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
    final rowsAffected = await dbHelper.update(row);
    //print("name ${t.getName()} learned ${t.getLearned()}");
    print('updated $rowsAffected row(s)');
  }

}
