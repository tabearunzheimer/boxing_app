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
    this._duration = duration;
    this._weekDay = weekDay;
   this._techniques = techniques;
   print("tag $day, monat $month, jahr $year");
    this._workoutTime =  DateTime(year, month, day);
  }

  ///creates a workout element from a given database or json
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

  ///calculates the burned calories
  ///weight must be in kg and time in minutes
  double calculateBurnedCalories(double weight, int time){
    return (weight/5)*time;
  }

  ///returns a String containing all techniques, separated with a comma
  String createTechniques(List<Technique> list){
    String erg = "";
    for (int i = 0; i < list.length; i++){
      erg += ", ${list[i].getName()}";
    }
    return erg;
  }

  ///returns the current date and time
  DateTime createWorkoutTime(){
    return DateTime.now();
  }

  ///returns the workoutTime as a readable string in format dd.mm.yyyy
  String getDateTimeString(){
    return "${this._workoutTime.day}.${this._workoutTime.month}.${this._workoutTime.year}";
  }

  ///returns the workout id
  int getId(){
    return this._id;
  }

  ///returns the workout type
  String getType(){
    return this._type;
  }

  ///returns the burned calories for the workout
  double getBurnedCalories(){
    return this._burnedCalories;
  }

  ///returns the duration of the whole workout as double
  double getDuration(){
    return this._duration;
  }

  ///returns the duration as a readable string in minutes and seconds
  String getDurationAsString(){
    //print("duration:_${((this._duration - this._duration.toInt()) * 100)}");
    return "${this._duration.toInt()} min ${((this._duration - this._duration.toInt()) * 100).toInt()} sek";
  }

  ///returns the weekday
  String getWeekDay(){
    return this._weekDay;
  }

  ///returns a string of techniques
  String getTechniques(){
    return this._techniques;
  }

  ///returns the day when the workout was
  DateTime getDateTime(){
    return this._workoutTime;
  }

  ///returns a list of the technique names
  List <String> separateTechniques(){
    List <String> split= _techniques.split(", ");
    return split;
  }

}