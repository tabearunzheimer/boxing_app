import 'package:flutter/material.dart';
import 'package:uebung02/screens/reusable_widgets.dart';

class ChooseWorkoutTechniques extends StatefulWidget {
  @override
  _ChooseWorkoutTechniquesState createState() =>
      new _ChooseWorkoutTechniquesState();
}

List <bool> _checkBoxVal = [false, false, false, false, false, false, false, false, false, false, false, false, false];

class _ChooseWorkoutTechniquesState extends State<ChooseWorkoutTechniques> {

  @override
  Widget build(BuildContext context) {
    List<String> list = [
      "Eins",
      "Zwei",
      "Drei",
      "Vier",
      "Fünf",
      "Sechs",
      "...",
      "...",
      "...",
      "...",
      "...",
      "...",
      "..."
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Kickbox App",),
        actions: <Widget>[
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) =>
            Divider(
              color: Color.fromRGBO(0, 0, 0, 0.8),
            ),
        padding: EdgeInsets.all(10.0),
        shrinkWrap: true,
        itemCount: list.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Text("Wähle die Techniken aus, die du trainieren möchtest",
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,);
          }
          index -= 1;
          return _buildTechniqueListItems(list, index, _checkBoxVal);
        },
      ),
    );
  }

  Widget _buildTechniqueListItems(List<Object> l, int index, List<bool> _checkBoxVal) {
    return ListTile(
      leading: Checkbox(
        value: _checkBoxVal[index],
        onChanged: (bool value) {
          print(_checkBoxVal[index]);
          setState(() => _checkBoxVal[index] = value);
          print(_checkBoxVal[index]);
        },
      ),
      title: Text(l[index], style: Theme.of(context).textTheme.display4,),
      subtitle: Text("Zuletzt: 06. November 2019", style: Theme.of(context).textTheme.display3,),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.security, color: Colors.black,),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.music_note, color: Colors.black,),
            onPressed: null,
          ),
        ],
      ),
      onTap: (){
        print("onTap: $_checkBoxVal[index] ");
        setState(() => _checkBoxVal[index] = _checkBoxVal[index] ? false: true);
        print("onTap: $_checkBoxVal[index] ");
      },
    );
  }

  /*
  dense: true,
      leading: Checkbox(
        onChanged: (bool value) {
          setState(() => this._checkBoxVal = value);
        },
        value: this._checkBoxVal,
      ),
      title: Text(l[index], style: TextStyle(fontSize: 15.0),),
      subtitle: Text("Datum: 06.11.2019"),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.security, color: Colors.black,),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.music_note, color: Colors.black,),
            onPressed: null,
          ),
        ],
      ),
      //oeffne Infos zum Kick
      onTap: null,
   */

}
