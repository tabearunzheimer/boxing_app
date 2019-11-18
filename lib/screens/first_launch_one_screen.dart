import 'package:flutter/material.dart';
import 'package:uebung02/screens/reusable_widgets.dart';

import 'first_launch_two_screen.dart';

class FirstLaunchScreenOne extends StatefulWidget {
  @override
  _FirstLaunchScreenOneState createState() => _FirstLaunchScreenOneState();
}

class _FirstLaunchScreenOneState extends State<FirstLaunchScreenOne> {
  ReusableWidgets r;

  @override
  void initState() {
    super.initState();
    r = new ReusableWidgets(context, -1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: r.getAppBar(),
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: new Image.asset(
              'assets/img/female_boxer.jpg',
              fit: BoxFit.cover,
              //height: 900.0,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Text(
                  "Willkommen",
                  style: Theme.of(context).textTheme.headline,
                ),
              ),
              Divider(
                color: Colors.white,
                indent: 100,
                endIndent: 100,
                thickness: 2,
              ),
              Container(
                padding: EdgeInsets.all(50),
                child: Text(
                  "Um dein Training zu optimieren bitten wir dich in den folgenden Screens ein paar Angaben zu machen. Diese werden nicht an Dritte weitergereicht sondern dienen lediglich zur besseren Nutzung der App. Du musst die Angaben nicht machen, aber es wäre gut.\n Viel Spaß mit der App.",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.all(20),
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.check,
                color: Colors.black,
              ),
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FirstLaunchScreenTwo()));
              },
            ),
          )
        ],
      ),
    );
  }
}
