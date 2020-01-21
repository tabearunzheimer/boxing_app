import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class WorkoutDatabaseHelper {
  static final _databaseName = "Workouts";
  static final _databaseVersion = 1;

  static final table = 'workout_table';

  static final columnId = '_id';
  static final columnType = 'type';
  static final columnBurnedCalories = 'burnedCalories';
  static final columnDuration = 'duration';
  static final columnWeekDay = 'weekDay';
  static final columnTechniques = 'techniques';
  static final columnTrainingDay = 'trainingDay';
  static final columnTrainingMonth = 'trainingMonth';
  static final columnTrainingYear = 'trainingYear';

  WorkoutDatabaseHelper._privateConstructor();

  static final WorkoutDatabaseHelper instance =
  WorkoutDatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  //oeffnet und gegebenenfalls erstellt die Datenbank
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  //erstellt die Tabelle
  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $table($columnId INTEGER PRIMARY KEY, $columnType STRING, $columnBurnedCalories DOUBLE, $columnDuration DOUBLE, $columnWeekDay STRING, $columnTechniques STRING, $columnTrainingDay INTEGER, $columnTrainingMonth INTEGER, $columnTrainingYear INTEGER)''');
  }

  // fuegt eine Spalte hinzu, rueckgabe-wert ist der wert der eingefuegten Spalte
  //Map<String, dynamic> row
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    /*
    Map<String, dynamic> r = {
      columnId: 1,
      columnType: "Offen",
      columnBurnedCalories: 100.5,
      columnDuration: 20.0,
      columnTrainingYear: 1999,
      columnTrainingMonth: 12,
      columnTrainingDay: 24,
      columnTechniques: 'Jab, Cross, Hook',
      columnWeekDay: 'Freitag',
    };
     */
    return await db.insert(table, row);
  }

  Future<List> getList(int id) async{
    Database db = await instance.database;
    final Future<List<Map<String, dynamic>>> map =  db.query(table, where: 'id = ?', whereArgs: [id]);
    var m = await map;
    return m;
  }

  //alle Spalten werden zurueckgegeben
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  //gibt alle Spalten zurueck
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  //update die Spalte mit dem gegebenem Namen
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db
        .update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  //loescht die Spalte anhand des Namens
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async{
    Database db = await instance.database;
    db.delete(table);
  }

}
