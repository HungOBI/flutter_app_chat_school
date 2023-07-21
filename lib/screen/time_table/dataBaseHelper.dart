import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDatabase();
    return _database;
  }

  DatabaseHelper.internal();

  Future<Database> initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'your_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE your_table (
        id INTEGER PRIMARY KEY,
        time TEXT,
        date TEXT,
        title TEXT,
        content TEXT,
        status BIT
      )
    ''');
  }

  Future<int> insertData(Map<String, dynamic> row, int id) async {
    Database? db = await database;
    row['id'] = id;
    return await db!.insert('your_table', row);
  }

  Future<List<Map<String, dynamic>>> getData() async {
    Database? db = await database;
    return await db!.query('your_table');
  }

// change status in file  database
  Future<int> updateStatus(int id, bool status) async {
    Database? db = await database;
    int statusValue = status ? 1 : 0;
    return await db!.update(
      'your_table',
      {'status': statusValue},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

// delete data in file database
  Future<int> deleteData(int id) async {
    Database? db = await database;
    return await db!.delete(
      'your_table',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

// get all date for event
  Future<List> getAllDates() async {
    Database? db = await database;
    List<Map<String, dynamic>> rows = await db!.query('your_table');
    List dates = rows.map((row) => row['date']).toList();
    return dates;
  }

// get all date and time use in notifi
  Future<List<DateTime>> getAllDateTime() async {
    Database? db = await database;
    List<Map<String, dynamic>> rows = await db!.query('your_table');
    List<DateTime> dateTimes = [];

    for (Map<String, dynamic> row in rows) {
      String dateString = row['date'];
      String timeString = row['time'];
      DateFormat dateFormat = DateFormat('M/d/yyyy H:mm');
      DateTime dateTime = dateFormat.parse('$dateString $timeString');
      dateTimes.add(dateTime);
    }

    return dateTimes;
  }
}
