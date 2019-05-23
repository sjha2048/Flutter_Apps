import 'package:flutter_mvp/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE user (id INTEGER PRIMARY KEY, username TEXT, password TEXT)");
    print("table is created");
  }

//insertion
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int response = await dbClient.insert("user", user.toMap());
    return response;
  }

//deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await db;
    int response = await dbClient.delete("user");
    return response;
  }
}
