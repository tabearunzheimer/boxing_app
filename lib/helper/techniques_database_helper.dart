import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class TechniquesDatabaseHelper{

  static final _databaseName = "Techniken";
  static final _databaseVersion = 1;

  static final table = 'my_table';

  static final columnName = '_name';
  static final columnType = 'type';
  static final columnAudio = 'audio';
  static final columnExplaination = 'explaination';
  static final columnLastTrainedDay = 'lastTrainedDay';
  static final columnLastTrainedMonth = 'lastTrainedMonth';
  static final columnLastTrainedYear = 'lastTrainedYear';

  TechniquesDatabaseHelper._privateConstructor();
  static final TechniquesDatabaseHelper instance = TechniquesDatabaseHelper._privateConstructor();

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
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);

  }

  //erstellt die Tabelle
  Future _onCreate(Database db, int version) async{
    await db.execute('''CREATE TABLE $table($columnName STRING PRIMARY KEY, $columnType STRING NOT NULL, $columnAudio STRING, $columnExplaination STRING, $columnLastTrainedDay INTEGER, $columnLastTrainedMonth INTEGER, $columnLastTrainedYear INTEGER)''');
  }

  // fuegt eine Spalte hinzu, rueckgabe-wert ist der wert der eingefuegten Spalte
  Future<int> insert(Map<String, dynamic> row)async{
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  //alle Spalten werden zurueckgegeben
  Future<List<Map<String, dynamic>>> queryAllRows()async{
    Database db = await instance.database;
    return await db.query(table);
  }

  //gibt alle Spalten zurueck
  Future<int> queryRowCount()async{
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  //update die Spalte mit dem gegebenem Namen
  Future<int> update(Map<String, dynamic> row)async{
    Database db = await instance.database;
    String id = row[columnName];
    return await db.update(table, row, where: '$columnName = ?', whereArgs: [id]);
  }

  //loescht die Spalte anhand des Namens
  Future<int> delete(int id )async{
    Database db = await instance.database;
    return await db.delete(table, where: '$columnName = ?', whereArgs: [id]);
  }


}