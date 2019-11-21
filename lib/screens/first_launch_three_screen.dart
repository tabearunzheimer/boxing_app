import 'package:flutter/material.dart';
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
          "Kickbox App",
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
        this.learnedTechniques[index].name,
        style: Theme.of(context).textTheme.display2,
      ),
      subtitle: Text("Datum: ${this.learnedTechniques[index].getLastTrained()}",
        style: Theme.of(context).textTheme.display3,
      ),
      trailing: this.learnedTechniques[index].getTypeIcon(),
      onTap: () {
        if (_checkBoxVal[index]) {
          print("entfernen");
          setState(() {
            //TODO: Entferne aus Datenbank
            _checkBoxVal[index] = false;
          });
        } else {
          setState(() {
            //TODO: Speichere in Datenbank
            _checkBoxVal[index] = true;
          });
        }
      },
    );
  }

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
}
