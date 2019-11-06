import 'package:flutter/material.dart';


class ReusableWidgets {

  BuildContext context;
  int selectedIndex;

  ReusableWidgets(BuildContext ctx, int index) {
    context = ctx;
    selectedIndex = index;
  }

  Widget getAppBar() {
    return AppBar(

      title: Text("Kickbox App", style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.8),),),
      actions: <Widget>[
        PopupMenuButton<int>(
            icon: Icon(Icons.more_vert, color: Color.fromRGBO(0, 0, 0, 0.8),),
            itemBuilder: (context) =>
            [
              PopupMenuItem(
                textStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.8),),
                value: 1,
                child: Text("Datenschutz"),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                textStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.8),),
                value: 2,
                child: Text("Einstellungen",),
              ),
            ]
        ),
      ],
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
    );
  }

  Widget getBottomNavigataionBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_run),
          title: Text('Training'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          title: Text('Tagebuch'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Ich'),
        ),
      ],
      selectedItemColor: Color.fromRGBO(200, 0, 0, 1),
      currentIndex: selectedIndex,
      onTap: onTapNavigation,
    );
  }

  void onTapNavigation(int value) {
    //setState(() {
    if (selectedIndex == value) {
      print("Aktueller Screen");
    } else {
      selectedIndex = value;
      switch (value) {
        case 0:
          print("Change to Home Screen");
          Navigator.pop(context);
          Navigator.pushNamed(context, '/home');
          break;
        case 1:
          print("Change to Diary Screen");
          Navigator.pop(context);
          Navigator.pushNamed(context, '/diary');
          break;
        case 2:
          print("Change to Me Screen");
          Navigator.pop(context);
          Navigator.pushNamed(context, '/me');
          break;
      }
    }


    // });
  }
}