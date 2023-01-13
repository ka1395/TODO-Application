// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';

class DBHelper {
  static Database? db;
  static const int version = 1;
  static const String tableName = 'tasks';
  static Future<void> intDb() async {
    if (db != null) {
      debugPrint('Not null dataBase');
      return;
    }
    try {
      // ignore: non_constant_identifier_names
      String Path = await getDatabasesPath() + 'taske';
      var db = await openDatabase(Path, version: version,
          onCreate: (Database db, int version) async {
        debugPrint('Creating a new dataBase');

        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'title STRING, note TEXT , data STRING ,'
            'startTime STRING,endTime STRING,'
            'remind INTEGER, repeat STRING,'
            'color INTEGER'
            'isCompleted INTEGER)');
      });
    } catch (e) {
      print(e);
    }
  }

   static Future<List<Map<String, dynamic>>> query() async {
    print('Quere Function Call');
    return await db!.query(tableName);
  }
  static Future<int> insert(Task task) async {
    print('Insert Function Call');
    return await db!.insert(tableName, task.toJson());
  }
   static Future<int> delete(Task task) async {
    print('Delet Function Call');
    return await db!.delete(tableName,where: 'id = ?',whereArgs: [task.id]);
  }
    static Future<int> update(int id) async {
    print('Update Function Call');
    return await db!.rawUpdate('''
    UPDATE tasks
    SET isCompleted = ?
    WERE id = ?

''',[1,id]);
  }
}
