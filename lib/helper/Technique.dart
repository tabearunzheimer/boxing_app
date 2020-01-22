import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Technique {
  String _name;
  int _id;
  String _erklaerung;
  String _link;
  String _type;
  bool _learned;
  bool _speaking;
  DateTime _lastTrained;
  FlutterTts _flutterTts;

  Technique(int id, String n, String e, String l, String t, String learned,
      int year, int month, int day) {
    this._id = id;
    this._name = n;
    this._erklaerung = e;
    this._link = l;
    this._type = t;
    _flutterTts = new FlutterTts();
    this._speaking = false;


    _flutterTts.setStartHandler((){
      this._speaking = true;
    });



    //if the technique was never trained use a default value
    if (year == 0 && month == 0 && day == 0) {
      this._lastTrained = DateTime(1000);
    } else {
      this._lastTrained = DateTime(year, month, day);
    }
    this._learned = (learned == 'false') ? false : true;
  }

  ///returns the name of a technique
  String getName() {
    return this._name;
  }

  ///returns the explanation of a technique
  String getErklaerung() {
    return this._erklaerung;
  }

  ///returns the link with a video of the technique
  String getLink() {
    return this._link;
  }

  ///returns the technique type e.g. defense or offense, block or combination
  String getType() {
    return this._type;
  }

  ///returns the last day you trained a technique
  ///if the user didn't train this technique it returns never trained
  String getLastTrained() {
    if (this._lastTrained.year == 1000) return "Noch nie trainiert";
    return "${this._lastTrained.day}.${this._lastTrained.month}.${this._lastTrained.year}";
  }

  ///returns an icon, depending on the technique type
  IconButton getTypeIcon() {
    switch (this._type) {
      case 'Offense':
        return IconButton(
          icon: Icon(
            Icons.gps_fixed,
            color: Colors.black,
          ),
          onPressed: null,
        );
        break;
      case 'Defense':
        return IconButton(
          icon: Icon(Icons.security, color: Colors.black),
          onPressed: null,
        );
        break;
      case 'Combo':
        return IconButton(
          icon: Icon(Icons.merge_type, color: Colors.black),
          onPressed: null,
        );
        break;
      default:
        return IconButton(
          icon: Icon(Icons.help_outline, color: Colors.black),
          onPressed: null,
        );
    }
  }

  ///returns an icon depending on whether the user learned the technique or not
  ///used for the displaying between learned and not learned technique list
  Icon getLearnedIcon() {
    if (this._learned) {
      return Icon(Icons.remove, color: Colors.black);
    } else {
      return Icon(Icons.add, color: Colors.black);
    }
  }

  ///converts a json from the database to a technique class element
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

  ///sorts a list of techniques
  ///learned techniques come first, not learned techniques second
  List<Technique> sortByLearned(List<Technique> l) {
    List<Technique> list = new List();
    List<Technique> unlearned = new List();
    for (int i = 0; i < l.length; i++) {
      if (l[i]._learned == true) {
        list.add(l[i]);
      } else {
        unlearned.add(l[i]);
      }
    }
    list.addAll(unlearned);
    return list;
  }

  ///simple quick-sort algorithm to order the techniques by the id they were inserted
  void sortById(List<Technique> list, int left, int right) {
    int i = left;
    int j = right;
    int zwischenspeicher;
    int index = ((left + right) / 2).round();
    int pivot = list[index]._id;

    while (i <= j) {
      while (list[i]._id < pivot) {
        i++;
      }
      while (list[j]._id > pivot) {
        j--;
      }
      if (i <= j) {
        zwischenspeicher = list[i]._id;
        list[i].setId(list[j].getId());
        list[j].setId(zwischenspeicher);
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

  ///returns the last day the technique was trained
  int getDay() {
    return this._lastTrained.day;
  }

  ///returns the last month the technique was trained
  int getMonth() {
    return this._lastTrained.month;
  }

  ///returns the last year the technique was trained
  int getYear() {
    return this._lastTrained.year;
  }

  ///returns a String whether the technique was learned or not
  String getLearned() {
    return this._learned ? 'true' : 'false';
  }

  ///returns if a technique is learned or not
  bool getLearnedAsBool(){
    return this._learned;
  }

  ///sets if a technique is learned or not
  bool setLearnedAsBool(bool l){
    this._learned = l;
  }

  ///returns the id
  int getId(){
    return this._id;
  }

  ///changes the id
  int setId(int id){
    this._id = id;
  }

  ///lets the application say the name of the technique
  Future<bool> speak() async {
    String text = this._name;
    await _flutterTts.setLanguage("en-US");
    //flutterTts.setLanguage('de-DE');
    _flutterTts.setSpeechRate(1.5);
    _flutterTts.setVolume(1.0);
    _flutterTts.setPitch(1.0);
    await _flutterTts.speak(text.toLowerCase());
    Future.value(false);
  }
}
