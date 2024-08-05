import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/user_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'users.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT
      )
    ''');
  }

  Future<int> insertData(UserModel dataModel) async {
    var dbClient = await database;
    return await dbClient.insert('users', dataModel.toJson());
  }

  Future<List<UserModel>> getAllUsers() async {
    var dbClient = await database;
    List<Map<String, dynamic>> result = await dbClient.query('users');
    return result.map((e) => UserModel.fromJson(e)).toList();
  }

  Future<void> deleteUser(int userId) async {
    var dbClient = await database;
    await dbClient.delete('users', where: 'id = ?', whereArgs: [userId]);
  }

  Future<void> updateUser(UserModel user) async {
    var dbClient = await database;
    await dbClient.update(
      'users',
      user.toJson(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }





}