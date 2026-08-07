import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'user.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'geeksforgeeks.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE users_table(id INTEGER PRIMARY KEY, name TEXT, email TEXT);',
    );
  }

  //CREATE

  Future<int> insertUser(User user) async {
    Database db = await instance.database;
    return await db.insert('users_table', user.toMap());
  }

  //READ

  // Future<List<Map<String, dynamic>>> querryAllUsers() async {
  //   Database db = await instance.database;
  //   return await db.query('users_table');
  // }
  
  Future<List<User>> querryAllUsers() async {
    final db = await instance.database;
    final result = await db.query('users');
    return result.map((e) => User.fromMap(e)).toList();
  }

  //UPDATE
  Future<int> updateUser(User user) async {
    Database db = await instance.database;
    return await db.update(
      'users_table',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  //DELETE
  Future<int> deleteUser(int id) async {
    Database db = await instance.database;
    return await db.delete('users_table',where: 'id=?',whereArgs: [id]);
  }
}



// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DBHelper {
//   static final DBHelper instance = DBHelper._init();
//   static Database? _db;

//   DBHelper._init();

//   Future<Database> get database async {
//     if (_db != null) return _db!;
//     _db = await _initDB('users.db');
//     return _db!;
//   }

//   Future<Database> _initDB(String file) async {
//     final path = join(await getDatabasesPath(), file);

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
//           CREATE TABLE users(
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             name TEXT,
//             age INTEGER
//           )
//         ''');
//       },
//     );
//   }

//   CREATE
//   Future<int> insert(User user) async {
//     final db = await instance.database;
//     return await db.insert('users', user.toMap());
//   }

//   READ
//   Future<List<User>> getAll() async {
//     final db = await instance.database;
//     final result = await db.query('users');
//     return result.map((e) => User.fromMap(e)).toList();
//   }

//   UPDATE
//   Future<int> update(User user) async {
//     final db = await instance.database;
//     return db.update(
//       'users',
//       user.toMap(),
//       where: 'id=?',
//       whereArgs: [user.id],
//     );
//   }

//   DELETE
//   Future<int> delete(int id) async {
//     final db = await instance.database;
//     return db.delete('users', where: 'id=?', whereArgs: [id]);
//   }
// }
