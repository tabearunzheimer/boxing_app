import 'package:flutter/material.dart';
import 'package:uebung02/helper/current_workout_information.dart';

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

List<bool> _checkBoxVal = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false
];

class _ChooseWorkoutTechniquesState extends State<ChooseWorkoutTechniques> {
  List<String> techniques;
  List<String> list;

  @override
  void initState() {
    super.initState();
    this.techniques = new List();
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.workoutInformation.getBreakTime());

    this.list = [
      "Eins",
      "Zwei",
      "Drei",
      "Vier",
      "Fünf",
      "Sechs",
      "Sieben",
      "Acht",
      "Neun",
      "Zehn",
      "Elf",
      "Zwölf",
      "Dreizehn"
    ];

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
          return _buildTechniqueListItems(list, index, _checkBoxVal);
        },
      ),
    );
  }

  Widget _buildTechniqueListItems(
      List<Object> l, int index, List<bool> _checkBoxVal) {
    return ListTile(
      leading: Checkbox(
        value: _checkBoxVal[index],
        onChanged: (bool value) {
          //print(_checkBoxVal[index]);
          setState(() => _checkBoxVal[index] = value);
          //print(_checkBoxVal[index]);
        },
      ),
      title: Text(
        l[index],
        style: Theme.of(context).textTheme.display2,
      ),
      subtitle: Text(
        "Zuletzt: 06. November 2019",
        style: Theme.of(context).textTheme.display3,
      ),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.security,
              color: Colors.black,
            ),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(
              Icons.music_note,
              color: Colors.black,
            ),
            onPressed: null,
          ),
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

  void addToTechniquesList(int index) {
    this.techniques.add(this.list[index]);
  }

  void removeFromTechniquesList(int index) {
    for (int i = 0; i < this.techniques.length; i++) {
      if (this.techniques[i].contains(this.list[index])) {
        this.techniques.removeAt(i);
      }
    }
  }

  void moveToChooseWorkoutSummaryScreen() {
    print("Change to choose-Workout-Summary-Screen");
    widget.workoutInformation.addTechniques(this.techniques);
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseWorkoutSummaryScreen(widget.workoutInformation)),);
  }
}
