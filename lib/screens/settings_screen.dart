import 'package:flutter/material.dart';
import 'package:uebung02/screens/reusable_widgets.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int radioButtonValue = 0;

  @override
  Widget build(BuildContext context) {
    ReusableWidgets reusableWidgets = new ReusableWidgets(context, -1);
    return Scaffold(
      appBar: reusableWidgets.getSimpleAppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Einstellungen",
                style: Theme.of(context).textTheme.display4,
              ),
              Divider(
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Sprache",
                    style: Theme.of(context).textTheme.body2,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "Deutsch",
                        style: Theme.of(context).textTheme.body2,
                      ),
                      Radio(
                        value: 0,
                        groupValue: radioButtonValue,
                        onChanged: handleRadioButtonValueChange,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "English",
                        style: Theme.of(context).textTheme.body2,
                      ),
                      Radio(
                        value: 1,
                        groupValue: radioButtonValue,
                        onChanged: handleRadioButtonValueChange,
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                color: Colors.black38,
              ),
              RaisedButton(
                  child: Text(
                    "Persönliche Daten löschen",
                    style: Theme.of(context).textTheme.body2,
                  ),
                  color: Colors.white,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text("Vorsicht!"),
                        content: Text(
                            "Möchten Sie Ihre Daten wirklich löschen?\nDies beinhaltet die Angaben zu Ihrer Person (Alter, Gewicht, etc), sowie Informationen über die Techniken und Workouts."),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Löschen"),
                            onPressed: () {
                              Navigator.pop(context);
                              //TODO Löschen von shared prefs
                            },
                          ),
                          FlatButton(
                            child: Text("Abbrechen"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
              ),
              Divider(
                color: Colors.black38,
              ),
              RaisedButton(
                child: Text(
                  "Zurücksetzen auf Werkszustand",
                  style: Theme.of(context).textTheme.body2,
                ),
                color: Colors.white,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text("Vorsicht!"),
                      content: Text(
                          "Möchten Sie die App wirklich zurücksetzen?\nDies löscht alle getroffenen Einstellungen und Präferenzen."),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Löschen"),
                          onPressed: () {
                            Navigator.pop(context);
                            //TODO löschen von shared prefs und zurücksetzen auf first launch
                          },
                        ),
                        FlatButton(
                          child: Text("Abbrechen"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleRadioButtonValueChange(int value) {
    setState(() {
      this.radioButtonValue = value;
    });
  }
}
