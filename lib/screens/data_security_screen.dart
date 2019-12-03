import 'package:flutter/material.dart';
import 'package:uebung02/screens/reusable_widgets.dart';

class DataSecurityScreen extends StatefulWidget {
  @override
  _DataSecurityScreenState createState() => _DataSecurityScreenState();
}

class _DataSecurityScreenState extends State<DataSecurityScreen> {
  @override
  Widget build(BuildContext context) {
    ReusableWidgets reusableWidgets = new ReusableWidgets(context, -1);
    return Scaffold(
      appBar: reusableWidgets.getSimpleAppBar(),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Anbieter", style: Theme.of(context).textTheme.display4,),
            Text("Tabea Runzheimer", style: Theme.of(context).textTheme.body2),
            Text("Danzigerstraße 14", style: Theme.of(context).textTheme.body2),
            Text("35075 Gladenbach", style: Theme.of(context).textTheme.body2),
            Text("Deutschland", style: Theme.of(context).textTheme.body2),
            Divider(
              color: Colors.black45,
            ),
            Text("Zugriffsberechtigungen", style: Theme.of(context).textTheme.display4,),
            Text("Fotos/Medien/Dateien", style: Theme.of(context).textTheme.body2),
           Container(
             margin: EdgeInsets.only(left: 10, bottom: 20),
             child: Text("Wir benötigen den Zugriff auf die Bilder Ihres Gerätes. Bei einer Anfrage zeigt die App Ihre aktuellen Dateien an, um diese als Profilbild nutzen zu können. Datein werden nur für die Bearbeitung Ihrer Anfrage genutzt. Es erfolgt keine Übertragung Ihrer Dateien.", style: Theme.of(context).textTheme.body2),
           ),
            Text("Ihre Daten werden nicht an Dritte weitergegeben.", style: Theme.of(context).textTheme.body2),
            Divider(
              color: Colors.black45,
            ),
            Text("Datum 03.12.2019", style: Theme.of(context).textTheme.body2),
          ],
        ),
      ),
    );
  }
}
