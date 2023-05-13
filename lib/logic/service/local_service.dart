import 'package:sqflite/sqflite.dart';
import '../../constant/local_string.dart';
import '../database/local_database.dart';
import 'package:path/path.dart';

class LocalService {
  var database = LocalDatabase.db.database;

  readData({required String table}) async {
    Database? db = await database;
    return await db!.query(table);
  }

  insertData({
    required String table,
    required Map<String, Object?> values,
  }) async {
    Database? db = await database;
    return await db!.insert(table, values);
  }

  updateData({
    required String table,
    required Map<String, Object?> values,
    required int id,
  }) async {
    Database? db = await database;
    return await db!.update(
      table,
      values,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  deleteData({required String table, required int? id}) async {
    Database? db = await database;
    return await db!.delete(
      table,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  deleteLocalDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(
      databasePath,
      LocalString.databaseName,
    );
    deleteDatabase(path);
  }
}
