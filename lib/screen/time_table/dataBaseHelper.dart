import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
        status BOOL,
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

  // Future<int> updateData(Map<String, dynamic> row) async {
  //   Database? db = await database;
  //   int id = row['id'];
  //   return await db!.update(
  //     'your_table',
  //     row,
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );
  // }

  Future<int> updateStatus(int id, bool status) async {
    Database? db = await database;
    return await db!.update(
      'your_table',
      {'status': status},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteData(int id) async {
    Database? db = await database;
    return await db!.delete(
      'your_table',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List> getAllDates() async {
    Database? db = await database;
    List<Map<String, dynamic>> rows = await db!.query('your_table');
    List dates = rows.map((row) => row['date']).toList();
    return dates;
  }
}
