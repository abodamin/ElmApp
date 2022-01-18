// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:io';

import 'package:elm_application/data/local_models/record.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const String _dbName = "ElmMoviesAppDB";
const String _dbTable = "Movies";

class SQLiteDbProvider {
  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDB();
    }
    return _database;
  }

  //SQLite does not have a separate Boolean storage class.
  //Instead, Boolean values are stored as integers 0 (false) and 1 (true).
  Future initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "$_dbName.db");
    var result = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE $_dbTable ("
        "id TEXT PRIMARY KEY, "
        "author TEXT , "
        "content TEXT , "
        "isLiked INTEGER)",
      );
    });
    // notifyListeners();
    return result;
  }

  Future<List<Map<dynamic, dynamic>>> getLikedQuotes() async {
    final db = await database;
    List<Map> results =
        await db!.rawQuery("SELECT * FROM $_dbTable WHERE isLiked = 1");
    List<Record> records = [];
    results.forEach((result) {
      Record record = Record.fromMap(result);
      records.add(record);
    });
    return results;
  }

  Future<List<Record>> getAllRecords() async {
    final db = await database;
    List<Map> results =
        await db!.query(_dbTable, columns: Record.columns, orderBy: "id ASC");

    List<Record> records = [];
    results.forEach((result) {
      Record record = Record.fromMap(result);
      records.add(record);
    });
    return records;
  }

  Future<Record?> getRecordById(String id) async {
    final db = await database;
    var result = await db!.query(_dbTable, where: "id = ", whereArgs: [id]);
    return result.isNotEmpty ? Record.fromMap(result.first) : null;
  }

  insertList(List<Record> records) async {
    final db = await database;
    var result;

    for (int i = 0; i < records.length; i++) {
      try {
        result = await db!.rawInsert(
            "INSERT Into $_dbTable (id, author, content, isLiked)"
            " VALUES (?, ?, ?, ?)",
            [
              records[i].id,
              records[i].author,
              records[i].content,
              records[i].isLiked,
            ]);
      } catch (e) {
        debugPrint("catched error $e");
      }
    }
    return result;
  }

  insert(Record record) async {
    final db = await database;
    var result;

    ///manually doing auto increment.
    // try {
    //   //get ID of last element then add 1.
    //   maxIdResult = await db
    //       .rawQuery("SELECT MAX(id)+1 as last_inserted_id FROM Records");
    //   id = maxIdResult.first["last_inserted_id"];
    // } catch (exception) {
    //if DB is Empty.
    // print("###### ERROR MESSAGE : $exception");
    // id = record.id;
    // } finally {
    result = await db!.rawInsert(
        "INSERT Into $_dbTable (id, author, content, isLiked)"
        " VALUES (?, ?, ?, ?)",
        [
          record.id,
          record.author,
          record.content,
          record.isLiked,
        ]);
    // }
    // notifyListeners();
    return result;
  }

  update(Record record) async {
    final db = await database;
    late int result;
    try {
      result = await db!.update(_dbTable, record.toMap(),
          where: "id = ?", whereArgs: [record.id]);
    } catch (e) {
      debugPrint("___ error in update error is >> $e");
    }
    return result;
  }

  delete(String id) async {
    final db = await database;
    await db!.delete(_dbTable, where: "id = ?", whereArgs: [id]);
    // notifyListeners();
  }

  deleteALL() async {
    final db = await database;
    await db!.delete(_dbTable);
  }
}
