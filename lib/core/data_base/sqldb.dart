import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, "ahmad.db");
    Database myDb = await openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute('''
               CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            task TEXT NOT NULL,
            description TEXT NOT NULL,
            dateTime TEXT NOT NULL,
            isComplete INTEGER NOT NULL
          )
        ''');
      },
      version: 1,
      onUpgrade: _onUpgrade,
    );

    return myDb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {}

  Future<List<Map<String, dynamic>>> readData(String sql) async {
    Database? myDb = await db;
    List<Map<String, dynamic>> response = await myDb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  updateData(String sql, List<Object?> list) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql, list);
    return response;
  }

  deleteData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }
}
