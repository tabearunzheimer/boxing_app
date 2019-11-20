import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Technique {
  String name;
  int id;
  String erklaerung;
  String link;
  String type;
  bool learned;
  DateTime lastTrained;
  FlutterTts flutterTts;

  Technique(int id, String n, String e, String l, String t, String learned,
      int year, int month, int day) {
    this.id = id;
    this.name = n;
    this.erklaerung = e;
    this.link = l;
    this.type = t;
    flutterTts = new FlutterTts();
    if (year == 0 && month == 0 && day == 0) {
      this.lastTrained = DateTime(1000);
    } else {
      this.lastTrained = DateTime(year, month, day);
    }
    this.learned = (learned == 'false') ? false : true;
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

  String getLastTrained() {
    if (this.lastTrained.year == 1000) return "Noch nie trainiert";
    return "${this.lastTrained.day}.${this.lastTrained.month}.${this.lastTrained.year}";
  }

  Icon getTypeIcon() {
    switch (this.type) {
      case 'Offense':
        return Icon(Icons.gps_fixed, color: Colors.black);
        break;
      case 'Defense':
        return Icon(Icons.security, color: Colors.black);
        break;
      case 'Combo':
        return Icon(Icons.merge_type, color: Colors.black);
        break;
      default:
        return Icon(Icons.help_outline, color: Colors.black);
    }
  }

  Icon getLearnedIcon() {
    if (this.learned) {
      return Icon(Icons.remove, color: Colors.black);
    } else {
      return Icon(Icons.add, color: Colors.black);
    }
  }

  factory Technique.fromJson(Map<String, dynamic> parsedJson) {
    Technique t = new Technique(
      parsedJson['_id'],
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

  List<Technique> sortByLearned(List<Technique> l) {
    List<Technique> list = new List();
    List<Technique> unlearned = new List();
    for (int i = 0; i < l.length; i++) {
      if (l[i].learned == true) {
        list.add(l[i]);
      } else {
        unlearned.add(l[i]);
      }
    }
    list.addAll(unlearned);
    return list;
  }

  //Quicksort
  void sortById(List<Technique> list, int left, int right) {
    int i = left;
    int j = right;
    int zwischenspeicher;
    int index = ((left + right) / 2).round();
    int pivot = list[index].id;

    while (i <= j) {
      while (list[i].id < pivot) {
        i++;
      }
      while (list[j].id > pivot) {
        j--;
      }
      if (i <= j) {
        zwischenspeicher = list[i].id;
        list[i].id = list[j].id;
        list[j].id = zwischenspeicher;
        i++;
        j--;
      }
    }

    if (left < j) {
      sortById(list, left, j);
    }
    if (i < right) {
      sortById(list, i, right);
    }
  }

  int getDay() {
    return this.lastTrained.day;
  }

  int getMonth() {
    return this.lastTrained.month;
  }

  int getYear() {
    return this.lastTrained.year;
  }

  String getLearned() {
    return this.learned ? 'true' : 'false';
  }

  Future speak() async {
    String text = this.name;
    await flutterTts.setLanguage("en-US");
    //flutterTts.setLanguage('de-DE');
    flutterTts.setSpeechRate(1.5);
    flutterTts.setVolume(1.0);
    flutterTts.setPitch(1.0);
    var result = await flutterTts.speak(text.toLowerCase());
  }
}
