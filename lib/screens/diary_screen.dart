import 'package:flutter/material.dart';
import 'package:uebung02/screens/reusable_widgets.dart';

class DiaryScreen extends StatefulWidget {
  @override
  _DiaryScreenState createState() => new _DiaryScreenState();
}

int selectedIndex = 1;
ReusableWidgets _reusableWidgets;

class _DiaryScreenState extends State<DiaryScreen> {
  @override
  Widget build(BuildContext context) {
    _reusableWidgets = new ReusableWidgets(context, selectedIndex);
    List<String> ll = ["Erlernte Techniken", "Zu lernende Techniken", "Workouts", "Statistiken"];
    List<String> l = ["Eins", "Zwei", "Drei", "Vier", "Fünf", "Sechs", "..."];
    return new Scaffold(
      appBar: _reusableWidgets.getAppBar(),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Color.fromRGBO(0, 0, 0, 0.8),
        ),
        itemCount: ll.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {return _buildExpansionTile(ll, l, index);},
      ),
      bottomNavigationBar: _reusableWidgets.getBottomNavigataionBar(),
    );
  }

  Widget _buildExpansionTile(List<Object> ll, List<String> l, int index) {
    return ExpansionTile(
      title: Text(ll[index]),
      children: <Widget>[
        ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Color.fromRGBO(0, 0, 0, 0.2),
          ),
          itemCount: l.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index){
            return _buildTechniqueListItems(l, index);
          },
        ),
      ],
    );
  }

  Widget _buildTechniqueListItems(List<Object> l, int index) {
    return ListTile(
      dense: true,
        leading: Icon(Icons.security,size: 30.0,),
        title: Text(l[index], style: TextStyle(fontSize: 15.0),),
        subtitle: Text("Datum: 06.11.2019"),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.music_note, color: Colors.black,),
              onPressed: null,
            ),
          ],
        ),
      //oeffne Infos zum Kick
      onTap: null,
      );
  }

}
