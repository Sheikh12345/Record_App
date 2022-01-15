import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart ';

class DatabaseHelperPurchase {
  static const _dbName = 'PaymentDatabase.db';
  static const _dbVersion = 1;
  static const tableName = 'Customers';
  static const columnId = '_id';
  static const columnName = 'name';
  static const columnCustomerName = 'customerName';
  static const columnPrice = 'price';
  static const columnDesc = 'description';
  static const columnDOPu = 'dateofpurchase';

  DatabaseHelperPurchase._privateConstructor();
  static final DatabaseHelperPurchase instance =
      DatabaseHelperPurchase._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initiateDatabase();
    }
    return _database;
  }

  initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    print("Table creating....");
    await db.execute('''
      CREATE TABLE $tableName(
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnName TEXT,
      $columnCustomerName TEXT,
      $columnPrice TEXT,
      $columnDesc TEXT,
      $columnDOPu TEXT)
      ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database as Database;
    return await db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database as Database;
    return await db.query(tableName);
  }

  Future<int> update(Map<String, dynamic> row, int column) async {
    Database db = await instance.database as Database;
    return await db
        .update(tableName, row, where: '$columnId = ?', whereArgs: [column]);
  }

  Future<int> delete(int columnID) async {
    Database db = await instance.database as Database;
    return await db
        .delete(tableName, where: '$columnId = ?', whereArgs: [columnID]);
  }
}
