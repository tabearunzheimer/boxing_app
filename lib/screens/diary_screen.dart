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
    List<String> l = ["Eins", "Zwei", "Drei", "Vier", "..."];
    return new Scaffold(
      appBar: _reusableWidgets.getAppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color.fromRGBO(0, 0, 0, 0.2),
        child: GridView.count(
          crossAxisCount: 1,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              color: Color.fromRGBO(255, 255, 255, 1),
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text("Erlernte Techniken",textAlign: TextAlign.start,),
                      IconButton(
                        onPressed: null,
                        icon: Icon(Icons.edit),
                      )
                    ],
                  ),
                  Divider(color: Color.fromRGBO(0, 0, 0, 0.8),),
                  ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      indent: 10.0,
                      endIndent: 10.0,
                    ),
                    itemCount: l.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index){
                      return _buildListItems(l, index);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _reusableWidgets.getBottomNavigataionBar(),
    );
  }

  /*
  ListView.builder(
                      itemCount: l.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index){
                        return _buildListItems(l, index);
                      },
                    ),
   */

  Widget _buildListItems(List<Object> l, int index) {
    return ListTile(
        dense: true,
        title: Text(l[index], style: TextStyle(fontSize: 15.0),),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.music_note, color: Colors.black,),
              onPressed: null,
            ),
            IconButton(
              icon: Icon(Icons.info, color: Colors.black,),
              onPressed: null,
            ),
          ],
        ),
      //oeffne Infos zum Kick
      onTap: null,
      );
  }
}


/*
Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              color: Color.fromRGBO(255, 255, 255, 1),
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Erlernte Techniken",),
                  Divider(color: Color.fromRGBO(0, 0, 0, 0.8),),
                  ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      indent: 10.0,
                      endIndent: 10.0,
                    ),
                    itemCount: l.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index){
                      return _buildListItems(l, index);
                    },
                  ),
                ],
              ),
            ),
 */