import 'package:flutter/material.dart';
import 'package:uebung02/screens/reusable_widgets.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

int selectedIndex = 0;
ReusableWidgets _reusableWidgets;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    _reusableWidgets = new ReusableWidgets(context, selectedIndex);
    return Scaffold(
      appBar: _reusableWidgets.getAppBar(),
      body:
      Stack(
        children: <Widget>[
          Center(
            heightFactor: MediaQuery.of(context).size.height,
            widthFactor: MediaQuery.of(context).size.width,
            child: new Image.asset('assets/img/female_boxer.jpg', fit: BoxFit.fill, height: 900.0,),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Start your workout",
                    style: TextStyle(
                        fontSize: 30.0, color: Colors.white
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: (){},
                    elevation: 10.0,
                    backgroundColor: Color.fromRGBO(255, 255, 255, 0.8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                    child: Icon(
                        Icons.play_arrow, size: 40.0, color: Colors.black,
                    ),

                  ),
                  Text("Stay motivated", style: TextStyle(fontSize: 20.0, color: Colors.white)),
                ]
            ),
          ),
        ],
      ),
      bottomNavigationBar: _reusableWidgets.getBottomNavigataionBar(),
    );
  }


}