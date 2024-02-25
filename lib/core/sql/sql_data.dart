import 'package:all_one/features/home/data/model/product_offer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;
  static final table = "my_table";

  static final columnId = 'id';
  static final columnTitle = 'title';

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only have a single app-wide reference to the database.
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  // Open the database and create the table if it doesn't exist.
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table.
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnTitle TEXT NOT NULL
          )
          ''');
  }

  // Helper methods for CRUD operations:
  Future<int> insert(DataProduct myDataModel) async {
    Database db = await database;
    return await db.insert(table, myDataModel.toJson());
  }

  Future<List<DataProduct>> queryAllRows() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (i) {
      return DataProduct(
        id: maps[i]['id'],
        title: maps[i]['title'],
      );
    });
  }
  Future<void> clearTable() async {
    Database db = await database;
    await db.delete(table);
  }
}