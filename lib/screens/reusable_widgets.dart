import 'package:flutter/material.dart';



///class with different widgets to reuse
class ReusableWidgets {

  BuildContext context;
  int selectedIndex;

  ReusableWidgets(BuildContext ctx, int index) {
    context = ctx;
    selectedIndex = index;
  }

  ///returns the appbar with only a title
  AppBar getSimpleAppBar(){
    return AppBar(
      title: Text("Martial Arts Trainer",),
    );
  }

  ///returns the full appbar
  Widget getAppBar() {
    return AppBar(
      title: Text("Martial Arts Trainer",),
      automaticallyImplyLeading: false,
      actions: <Widget>[
        PopupMenuButton<int>(
            icon: Icon(Icons.more_vert,),
            onSelected: (value){
              switch(value){
                case 1:
                  Navigator.pushNamed(context, '/DataSecurityScreen');
                  break;
                case 2:
                  Navigator.pushNamed(context, '/SettingsScreen');
                  break;
              }
            },
            itemBuilder: (context) =>
            [
              PopupMenuItem(
                value: 1,
                child: Text("Datenschutz"),
                enabled: true,
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                value: 2,
                child: Text("Einstellungen",),
              ),
            ]
        ),
      ],
    );
  }

  ///returns the full bottom navigation bar
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

  ///handles navigation on the bottom navigation bar
  void onTapNavigation(int value) {
    //setState(() {
    if (selectedIndex == value) {
      print("Aktueller Screen");
    } else {
      selectedIndex = value;
      switch (value) {
        case 0:
          print("Change to Home Screen");
          Navigator.pushReplacementNamed(context, '/home');
          break;
        case 1:
          print("Change to Diary Screen");
          //Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/diary');
          break;
        case 2:
          print("Change to Me Screen");
          Navigator.pushReplacementNamed(context, '/me');
          break;
      }
    }


    // });
  }
}