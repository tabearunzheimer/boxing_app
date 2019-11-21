import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class TechniquesDatabaseHelper {
  static final _databaseName = "Techniken";
  static final _databaseVersion = 1;

  static final table = 'techniques_table';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnType = 'type';
  static final columnLink = 'link';
  static final columnLearned = 'learned';
  static final columnExplanation = 'explaination';
  static final columnLastTrainedDay = 'lastTrainedDay';
  static final columnLastTrainedMonth = 'lastTrainedMonth';
  static final columnLastTrainedYear = 'lastTrainedYear';

  TechniquesDatabaseHelper._privateConstructor();

  static final TechniquesDatabaseHelper instance =
      TechniquesDatabaseHelper._privateConstructor();

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
        '''CREATE TABLE $table($columnId INTEGER PRIMARY KEY, $columnName STRING, $columnType STRING NOT NULL, $columnLink STRING, $columnExplanation STRING, $columnLearned STRING, $columnLastTrainedDay INTEGER, $columnLastTrainedMonth INTEGER, $columnLastTrainedYear INTEGER)''');
  }

  // fuegt eine Spalte hinzu, rueckgabe-wert ist der wert der eingefuegten Spalte
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<int> insertList() async {
    Database db = await instance.database;
    List<Map> list = initEntries();
    for (int i = 0; i < list.length; i++) {
      print('Insert $i');
      Map<String, dynamic> row = list[i];
      await db.insert(table, row);
    }
    return Future.value(0);
  }

  Future<List> getList(int id)async{
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
    String id = row[columnName];
    return await db
        .update(table, row, where: '$columnName = ?', whereArgs: [id]);
  }

  //loescht die Spalte anhand des Namens
  Future<int> delete(String id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnName = ?', whereArgs: [id]);
  }

  List<Map<String, dynamic>> initEntries() {
    List<Map<String, dynamic>> list = [
      {
        TechniquesDatabaseHelper.columnId: 1,
        TechniquesDatabaseHelper.columnName: 'Jab',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=CxyFoWIjltw',
        TechniquesDatabaseHelper.columnExplanation:
            'Schlag mit der Hand die näher zu deinem Gegner ist. Beziehungsweise ein Schlag mit der Hand dessen Fuß vorne steht. Wichtig ist hierbei die Schulter, Hüfte und Fuß mitzudrehen.',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 2,
        TechniquesDatabaseHelper.columnName: 'Cross',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=YI0uAx1QPvI',
        TechniquesDatabaseHelper.columnExplanation:
            'Schlag mit der Hand, die weiter entfernt von deinem Gegner ist. Beziehungsweise ein Schlag mit der Hand dessen Fuß hinten steht. Wichtig ist hierbei die Schulter, Hüfte und Fuß mitzudrehen.',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 3,
        TechniquesDatabaseHelper.columnName: 'Hook',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=x7PRrk8QGQ4',
        TechniquesDatabaseHelper.columnExplanation:
            'Ein Haken der normalerweise entweder auf das Gesicht oder die Leber zielt. Der Handrücken kann beim Auftreffen entweder nach oben oder zum Gegner zeigen.',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 4,
        TechniquesDatabaseHelper.columnName: 'Uppercut',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=ZmxyguvPwlo',
        TechniquesDatabaseHelper.columnExplanation:
            'Ein Haken der von unten ausgeführt auf das Kinn trifft. Der Handrücken sollte beim Auftreffen zum Gegner zeigen.',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 5,
        TechniquesDatabaseHelper.columnName: 'Liver-Hook',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=VD4D5RzeqjA',
        TechniquesDatabaseHelper.columnExplanation:
            'Ein Haken der seitlich auf die Leber trifft. Der Handrücken zeigt beim Auftreffen nach oben oder zum Gegner.',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 6,
        TechniquesDatabaseHelper.columnName: 'Overhand',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/results?search_query=overhand+tutorial',
        TechniquesDatabaseHelper.columnExplanation:
            'Der Schlag geht über die Hand des Gegners. Ausgeführt wird er wie der Wurf eines Baseballs, gegen den Kopf. Im Gegensatz zum Jab ist die Schlaglinie hier nicht gerade, sondern eher von der Seite. Eignet sich sehr gut, um einen Jab zu kontern. ',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 7,
        TechniquesDatabaseHelper.columnName: 'Spinning Backfist',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=7Vn2NycQDJw',
        TechniquesDatabaseHelper.columnExplanation:
            'Dreh deinen vorderen Fuß um 180°, nimm deinen Körper mit und dreh deinen Kopf soweit, dass du deinen Gegner wiedersiehst. Nimm die Kraft aus der Drehung und schlag deinen Gegner mit dem Handrücken.',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 8,
        TechniquesDatabaseHelper.columnName: 'Elbow',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=1QLgwAHaQlM',
        TechniquesDatabaseHelper.columnExplanation:
            'Man zielt auf den Kopf und trifft den Gegner mit dem Ellbogen. Ein gutes Ziel ist über den Augenbrauen, da die Stelle schnell blutet und dies den Gegner irritiert.',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 9,
        TechniquesDatabaseHelper.columnName: 'Uppercut Elbow',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=bzbPaglKW4o',
        TechniquesDatabaseHelper.columnExplanation:
            'Man schlägt den Ellbogen von unten gegen das Kinn des Gegners.',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 10,
        TechniquesDatabaseHelper.columnName: 'Spinning Elbow',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=BX5DkOpS154',
        TechniquesDatabaseHelper.columnExplanation:
            'Dreh deinen vorderen Fuß um 180° und lass deinen Körper folgen. Drehe deinen Kopf soweit, dass du deinen Gegner wiedersiehst und lehne dich etwas zum ihm, um ihn mit dem Ellbogen zu treffen.',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 11,
        TechniquesDatabaseHelper.columnName: 'Front Kick',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=kGp3ZnJcS5s',
        TechniquesDatabaseHelper.columnExplanation:
            'Das hintere Bein tritt den Gegner im Bereich des Bauchs. Man sollte auf einen festen Stand achten.',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 12,
        TechniquesDatabaseHelper.columnName: 'Low Kick',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=Rm_6-TQHiu0',
        TechniquesDatabaseHelper.columnExplanation:
            'Das hintere Bein trifft den Gegner von der Seite. Ziel ist der Bereich zwischen Hüfte und Knie.',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 13,
        TechniquesDatabaseHelper.columnName: 'Round House Kick',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=HlL-wf1ec0M',
        TechniquesDatabaseHelper.columnExplanation:
            'Das hintere Bein trifft den Gegner von der Seite. Das Ziel liegt in Höhe des Bauchs und der Arme.',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 14,
        TechniquesDatabaseHelper.columnName: 'Round House Kick High',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=ZsljR6pD5oI',
        TechniquesDatabaseHelper.columnExplanation:
            'Das hintere Bein trifft den Gegner von der Seite. Das Ziel ist der Kopf, beziehungsweise die Ohren.',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 15,
        TechniquesDatabaseHelper.columnName: 'Knee',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=tvhePDsYSXA',
        TechniquesDatabaseHelper.columnExplanation:
            'Zieh dein hinteres Bein gerade nach vorne, lehne deinen Oberkörper etwas zurück und triff deinen Gegner mit dem Knie.',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 16,
        TechniquesDatabaseHelper.columnName: 'Switch Kick',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=Hl4xhjTzT08',
        TechniquesDatabaseHelper.columnExplanation:
            'Man wechselt die Fußstellung durch einen Sprung. Der Vordere Fuß kommt dabei nach Hinter und der Hintere nach vorne. Danach kommt ein seitlicher Kick. ',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 17,
        TechniquesDatabaseHelper.columnName: 'Axe Kick',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=Xg9W4bIXOr0',
        TechniquesDatabaseHelper.columnExplanation:
            'Das hintere Bein geht gerade nach vorne und nach oben und dann gerade auf den Gegner herunter. Dabei erfolgt ein Stellungswechsel. Das hintere Bein ist anschließend das Vordere.',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 18,
        TechniquesDatabaseHelper.columnName: 'Side Kick',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=Ojd0j2CIaGU',
        TechniquesDatabaseHelper.columnExplanation:
            'Das hintere Bein geht nach vorne und trifft den Gegner im Bereich des Bauchs. Der Körper dreht sich dabei mit. Man kann anschließend das Bein wieder in die alte Stellung zurückbringen oder einen Stellungswechsel machen.',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 19,
        TechniquesDatabaseHelper.columnName: 'Front Round House Kick',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=BtnwY-j091A',
        TechniquesDatabaseHelper.columnExplanation:
            'Man täuscht zunächst einen Front Kick an, dreht dann das Standbein und führt einen Round House Kick aus.',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 20,
        TechniquesDatabaseHelper.columnName: 'Hook Kick',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=opaFWJAxRq0',
        TechniquesDatabaseHelper.columnExplanation:
            'Dein hinteres Bein bewegt sich nach vorne, während sich dein Oberkörper und dein anderer Fuß mitdrehen. Der Fuß, der am Boden bleibt sollte von dir weg zeigen. Der Kick geht zunächst an deinem Gegner vorbei, klappe dann dein Bein ein und triff ihn mit der Ferse oder dem kompletten Fuß.',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 21,
        TechniquesDatabaseHelper.columnName: 'Side Hook Kick',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=opaFWJAxRq0',
        TechniquesDatabaseHelper.columnExplanation:
            'Führe zunächst einen Side Kick aus und schließe dann mit einem Hook Kick an.',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 22,
        TechniquesDatabaseHelper.columnName: 'Back Kick',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=QjdZK27kfU4',
        TechniquesDatabaseHelper.columnExplanation:
            'Der vordere Fuß dreht sich um ca. 180°, dann nimmt man das hintere Bein hoch, dreht den Kopf um 360° um zu sehen wo der Gegner steht und dreht den Körper um 180° zusammen mit dem Fuß um einen Side Kick zu landen.',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 23,
        TechniquesDatabaseHelper.columnName: 'Spinning Hook Kick',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=dl-C3ExAk8Y',
        TechniquesDatabaseHelper.columnExplanation:
            'Beim Spinning Hook Kick dreht man sich zunächst und nutzt die Drehbewegung, um den Gegner mit mehr Kraft zu treffen.',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 24,
        TechniquesDatabaseHelper.columnName: 'Tornado Kick',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=1n5sR5m7OF0',
        TechniquesDatabaseHelper.columnExplanation:
            'Keine Erklärung vorhanden.',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 25,
        TechniquesDatabaseHelper.columnName: 'Superman Punch',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=SrxEe0Hxtyc',
        TechniquesDatabaseHelper.columnExplanation:
            'Ein Haken der normalerweise entweder auf das Gesicht oder die Leber zielt. Der Handrücken kann beim Auftreffen entweder nach oben oder zum Gegner zeigen.',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 26,
        TechniquesDatabaseHelper.columnName: 'Elbow Blitz',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=6qRDsPNaSoc',
        TechniquesDatabaseHelper.columnExplanation:
            'Keine Erklärung vorhanden.',
        TechniquesDatabaseHelper.columnType: 'Offense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 27,
        TechniquesDatabaseHelper.columnName: 'Straight Block',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=WEcv_JI85D8',
        TechniquesDatabaseHelper.columnExplanation:
            'Man wehrt den Punch ab, indem man auf derselben Seite den Schlag abfängt und von sich weg leitet. Schlägt der Gegner mit links, blockiert man mit rechts. Die andere Hand bleibt oben, um sich zu schützen.',
        TechniquesDatabaseHelper.columnType: 'Defense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 28,
        TechniquesDatabaseHelper.columnName: 'Hook Block',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=8ngdo-q2WiA',
        TechniquesDatabaseHelper.columnExplanation:
            'Aus der Abwehrhaltung heraus nimmt man den Arm auf der Seite wo der Hook kommt etwas herunter, damit er den Arm trifft.',
        TechniquesDatabaseHelper.columnType: 'Defense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 29,
        TechniquesDatabaseHelper.columnName: 'Uppercut Block',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=oOhhjhbAS-o',
        TechniquesDatabaseHelper.columnExplanation:
            'Man fängt den Schlag ab, indem man die Hand auf der Seite, von der der Schlag kommt, dem Uppercut entgegenführt und mit der Hand-Innenseite abfängt. Die andere Hand bleibt zum Schutz oben. Wahlweise könnte man auch einen Schritt zurück machen. ',
        TechniquesDatabaseHelper.columnType: 'Defense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 30,
        TechniquesDatabaseHelper.columnName: 'Bodyshot Block',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=8ngdo-q2WiA',
        TechniquesDatabaseHelper.columnExplanation:
            'Geeignet für Haken zur Leber. Man zieht den Arm auf der Seite, auf der man angegriffen wird, hinunter.',
        TechniquesDatabaseHelper.columnType: 'Defense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 31,
        TechniquesDatabaseHelper.columnName: 'Front Kick Block',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=kfmO67CN7fY',
        TechniquesDatabaseHelper.columnExplanation:
            'Man leitet das Bein an sich vorbei mit der gegenüberliegenden Hand.',
        TechniquesDatabaseHelper.columnType: 'Defense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 32,
        TechniquesDatabaseHelper.columnName: 'Low Kick Block',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=YSRmPDWYXKU',
        TechniquesDatabaseHelper.columnExplanation:
            'Nimm das Bein nach oben und blockiere den Kick mit deinem Schienbein. Behalte einen festen Stand.',
        TechniquesDatabaseHelper.columnType: 'Defense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 33,
        TechniquesDatabaseHelper.columnName: 'Knee Block',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=JfftU5-zRNw',
        TechniquesDatabaseHelper.columnExplanation:
            'Nimm beide Hände über Kreuz nach unten, fang das Knie auf und mach je nach Situation einen Schritt zurück-',
        TechniquesDatabaseHelper.columnType: 'Defense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 34,
        TechniquesDatabaseHelper.columnName: 'Side Kick Block',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=Y7--ERM-gpA',
        TechniquesDatabaseHelper.columnExplanation:
            'Nimm den Arm auf der Seite, auf der du angegriffen wirst, leicht hinunter und lass den Fuß deines Gegners auf deinen Oberarm treffen.',
        TechniquesDatabaseHelper.columnType: 'Defense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 35,
        TechniquesDatabaseHelper.columnName: 'High Kick Block',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=Nv5AVzL_JGI',
        TechniquesDatabaseHelper.columnExplanation:
            'Auf der Seite, auf der du angegriffen wirst, geht die Hand Richtung Ohr, sodass dein Gegner den Arm trifft. Du kannst zusätzlich deine andere Hand zu der Seite führen und versuchen den Kick auszubremsen oder abzufangen.',
        TechniquesDatabaseHelper.columnType: 'Defense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
      {
        TechniquesDatabaseHelper.columnId: 36,
        TechniquesDatabaseHelper.columnName: 'Duck Under',
        TechniquesDatabaseHelper.columnLink:
            'https://www.youtube.com/watch?v=tkbqpTD2aHs',
        TechniquesDatabaseHelper.columnExplanation:
            'Man duckt sich unter einem Schlag weg. Perfekt für einen seitlichen Hook zum Kopf oder einem Round House Kick High.',
        TechniquesDatabaseHelper.columnType: 'Defense',
        TechniquesDatabaseHelper.columnLearned: 'false',
        TechniquesDatabaseHelper.columnLastTrainedDay: 00,
        TechniquesDatabaseHelper.columnLastTrainedMonth: 00,
        TechniquesDatabaseHelper.columnLastTrainedYear: 0000,
      },
    ];

    return list;
  }
}
