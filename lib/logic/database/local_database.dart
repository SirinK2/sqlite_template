import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlite_template/constant/local_string.dart';


class LocalDatabase {
  LocalDatabase._();

  static final LocalDatabase db = LocalDatabase._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, LocalString.databaseName);
    Database favDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return favDatabase;
  }

  _onCreate(Database db, int ver) async {
    await db.execute('''
    CREATE TABLE "${LocalString.tableName}"(
    "${LocalString.columnId}" INTEGER NOT NULL PRIMARY KEY,
    "${LocalString.columnTitle}" TEXT NOT NULL,
    "${LocalString.columnDescription}" TEXT NOT NULL,
    "${LocalString.columnDate}" TEXT NOT NULL
     )
    ''');
  }

}
