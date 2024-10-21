import 'package:lab_1/models/audit_class.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/notes.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    return await db.execute('''
        CREATE TABLE Audits (
          _id INTEGER PRIMARY KEY AUTOINCREMENT,
          audit TEXT NOT NULL
        )
      ''');
  }

  Future<AuditClass> create(AuditClass a) async {
    final db = await instance.database;
    final id = await db.insert("Audits", a.toJson());
    return a.copy(id: id);
  }

  Future<AuditClass> read(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      "Audits",
      columns: ["_id", "audit"],
      where: '_id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return AuditClass.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<AuditClass>> readAll() async {
    final db = await instance.database;
    const orderBy = '_id ASC';
    final result = await db.query("Audits", orderBy: orderBy);
    return result.map((json) => AuditClass.fromJson(json)).toList();
  }
}
