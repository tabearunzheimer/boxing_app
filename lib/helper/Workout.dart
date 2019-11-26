/*
  static final columnId = '_id';
  static final columnBurnedCalories = 'burnedCalories';
  static final columnDuration = 'duration';
  static final columnWeekDay = 'weekDay';
  static final columnTechniques = 'techniques';
  static final columnTrainingDay = 'trainingDay';
  static final columnTrainingMonth = 'trainingMonth';
  static final columnTrainingYear = 'trainingYear';
 */

import 'Technique.dart';

class Workout {

  int _id;
  String _type;
  double _burnedCalories;
  double _duration;
  String _weekDay;
  String _techniques;
  DateTime _workoutTime;

  Workout(int id, String type, double burnedCalories, double duration, String weekDay, String techniques, int year, int month, int day){
    this._id  = id;
    this._type = type;
    this._burnedCalories = burnedCalories;
    duration = duration.roundToDouble();
    this._duration = duration;
    this._weekDay = weekDay;
   this._techniques = techniques;
   print("tag $day, monat $month, jahr $year");
    this._workoutTime =  DateTime(year, month, day);
  }

  factory Workout.fromJson(Map<String, dynamic> parsedJson) {
    //print(" ID: ${parsedJson['trainingDay']}");
    Workout w = new Workout(
      parsedJson['_id'],
      parsedJson['type'],
      parsedJson['burnedCalories'],
      parsedJson['duration'],
      parsedJson['weekDay'],
      parsedJson['techniques'],
      parsedJson['trainingYear'],
      parsedJson['trainingMonth'],
      parsedJson['trainingDay'],
    );
    print(" TYPE: ${w.getType()}");
    return w;
  }

  //zeit in minuten, gewicht in kg
  double calculateBurnedCalories(double weight, int time){
    return (weight/5)*time;
  }

  String createTechniques(List<Technique> list){
    String erg = "";
    for (int i = 0; i < list.length; i++){
      erg += ", ${list[i].name}";
    }
    return erg;
  }

  DateTime createWorkoutTime(){
    return DateTime.now();
  }

  String getDateTimeString(){
    return "${this._workoutTime.day}.${this._workoutTime.month}.${this._workoutTime.year}";
  }

  int getId(){
    return this._id;
  }

  String getType(){
    return this._type;
  }

  double getBurnedCalories(){
    return this._burnedCalories;
  }

  double getDuration(){
    return this._duration;
  }

  String getWeekDay(){
    return this._weekDay;
  }

  String getTechniques(){
    return this._techniques;
  }

  DateTime getDateTime(){
    return this._workoutTime;
  }

}