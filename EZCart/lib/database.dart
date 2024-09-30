import 'dart:ffi';
import 'dart:math';
import 'package:sqflite/sqflite.dart';
import 'models/product.dart';
import 'package:path/path.dart';

class EZCartDB {
  final tableName = 'products';

  Future<void> createTable(Database database) async {
    await database.execute("""
    CREATE TABLE IF NOT EXISTS $tableName (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    lableTitle TEXT NOT NULL,
    lablePrice TEXT NOT NULL,
    amount INTEGER NOT NULL
    )
    """);
  }

  Future<List<Product>> get fetchAll async {
    final database = await DatabaseService().database;
    final data = await database.query(tableName);
    List<Product> products = data.map(
          (e) => Product(
          e['amount'] as int?,
          e['lablePrice'] as String?,
          e['lableTitle'] as String?
      ),
    ).toList();
    print("from DB: ${data}");
    return products;
  }

  Future<int> create({required String title, required double price, required int amount}) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName (lableTitle, lablePrice, amount) VALUES (?,?,?)''',
      [title, price, amount]
    );
  }

}

class DatabaseService {

  Database? _database;

  Future<Database> get database async {
    if(_database != null) {
      return _database!;
    }

    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'ezcart.db';
    final path = await getDatabasesPath();
    return (join(path, name));
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
    );

    return database;
  }

  Future<void> create(Database database, int version) async => await EZCartDB().createTable(database);
}