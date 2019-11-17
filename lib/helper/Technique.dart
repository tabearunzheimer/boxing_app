import 'package:flutter/material.dart';

class Technique {
  String name;
  String erklaerung;
  String link;
  String type;
  bool learned;
  DateTime lastTrained;

  Technique(String n, String e, String l, String t, String learned, int year,
      int month, int day) {
    this.name = n;
    this.erklaerung = e;
    this.link = l;
    this.type = t;
    if (year == 0 && month == 0 && day == 0){
      this.lastTrained = DateTime(1000);
    } else {
      this.lastTrained = DateTime(year, month, day);
    }
    this.learned = (learned=='false') ? false : true;
  }

  String getName() {
    return this.name;
  }

  String getErklaerung() {
    return this.erklaerung;
  }

  String getLink() {
    return this.link;
  }

  String getType() {
    return this.type;
  }

  String getLastTrained(){
    if (this.lastTrained.year == 1000) return "Noch nie trainiert";
    return "${this.lastTrained.day}.${this.lastTrained.month}.${this.lastTrained.year}";
  }

  Icon getTypeIcon() {
    switch (this.type) {
      case 'Offense':
        return Icon(Icons.gps_fixed);
        break;
      case 'Defense':
        return Icon(Icons.security);
        break;
      case 'Combo':
        return Icon(Icons.merge_type);
        break;
      default:
        return Icon(Icons.help_outline);
    }
  }

  Icon getLearnedIcon() {
    if (this.learned){
      return Icon(Icons.remove,
        color: Colors.black);
    } else {
      return Icon(Icons.add,
          color: Colors.black
      );
    }
  }

  factory Technique.fromJson(Map<String, dynamic> parsedJson) {
    Technique t = new Technique(
      parsedJson['name'],
      parsedJson['explaination'],
      parsedJson['link'],
      parsedJson['type'],
      parsedJson['learned'],
      parsedJson['lastTrainedYear'],
      parsedJson['lastTrainedMonth'],
      parsedJson['lastTrainedDay'],
    );
    return t;
  }
}
