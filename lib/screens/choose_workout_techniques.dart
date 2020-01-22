import 'package:flutter/material.dart';
import 'package:uebung02/helper/Technique.dart';
import 'package:uebung02/helper/current_workout_information.dart';
import 'package:uebung02/helper/techniques_database_helper.dart';

import 'choose_workout_summary_screen.dart';

class ChooseWorkoutTechniques extends StatefulWidget {
  CurrentWorkoutInformation workoutInformation;

  ChooseWorkoutTechniques(CurrentWorkoutInformation cOld) {
    this.workoutInformation = cOld;
  }

  @override
  _ChooseWorkoutTechniquesState createState() =>
      new _ChooseWorkoutTechniquesState();
}


class _ChooseWorkoutTechniquesState extends State<ChooseWorkoutTechniques> {
  List<Technique> techniques;
  List<Technique> list;
  List<bool> _checkBoxVal;
  final dbHelper = TechniquesDatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    this.techniques = new List();
    this.list = new List();
    this._checkBoxVal = new List();
    createList();
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.workoutInformation.getBreakTime());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kickbox App",
        ),
        actions: <Widget>[
          IconButton(
            onPressed: moveToChooseWorkoutSummaryScreen,
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
        itemCount: list.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Text(
              "Wähle die Techniken aus, die du trainieren möchtest",
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

  ///returns a list of techniques the user can choose from by clicking the checkboxes
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
        this.list[index].getName(),
        style: Theme.of(context).textTheme.display2,
      ),
      subtitle: Text("Datum: ${this.list[index].getLastTrained()}",
        style: Theme.of(context).textTheme.display3,
      ),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.music_note, color: Colors.black,),
            onPressed: (){
              this.list[index].speak();
            },
          ),
          this.list[index].getTypeIcon(),
        ],
      ),
      onTap: () {
        if (_checkBoxVal[index]) {
          print("entfernen");
          setState(() {
            removeFromTechniquesList(index);
            _checkBoxVal[index] = false;
          });
        } else {
          setState(() {
            addToTechniquesList(index);
            _checkBoxVal[index] = true;
          });
        }
      },
    );
  }

  ///adds the given technique to a list
  void addToTechniquesList(int index) {
    this.techniques.add(this.list[index]);
  }

  ///removes the given technique from the list
  void removeFromTechniquesList(int index) {
    for (int i = 0; i < this.techniques.length; i++) {
      if (this.techniques.remove((this.list[index]))) {
        this.techniques.removeAt(i);
      }
    }
  }

  ///shows the next screen and passes the workout information
  void moveToChooseWorkoutSummaryScreen() {
    print("Change to choose-Workout-Summary-Screen");
    widget.workoutInformation.addTechniques(this.techniques);
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseWorkoutSummaryScreen(widget.workoutInformation)),);
  }

  ///creates the list of all techniques sorted by learned techniques
  void createList() async {
    List l;
    final allRows = await dbHelper.queryAllRows();
    final techniqueListLength = await dbHelper.queryRowCount();
    l = allRows.toList();
    List<Technique> alle = new List();
    for (int i = 0; i < techniqueListLength; i++) {
      Technique t = new Technique.fromJson(l.removeAt(0));
      alle.add(t);
    }

    Technique t = new Technique(0, "", "", "", "", "", 0, 0, 0);
    alle = t.sortByLearned(alle);

    setState(() {
      this.list = alle;
      for(int i = 0; i < alle.length; i++){
        this._checkBoxVal.add(false);
      }
      print("Liste uebergeben, laenge: ${list.length}");
    });
  }
}
