import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'family_database.db');
    return await openDatabase(
      path,
      version: 2, //increment the db version
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE family_data(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            relation TEXT,

            head_id TEXT,
            head_name TEXT,
            head_age INTEGER,
            head_occupation TEXT,
            head_gross_monthly_income REAL,
            head_mobile_number TEXT
          )
        ''');
      },

      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            ALTER TABLE family_data
            ADD COLUMN head_id TEXT;
          ''');
          await db.execute('''
            ALTER TABLE family_data
            ADD COLUMN head_name TEXT;
          ''');
          await db.execute('''
            ALTER TABLE family_data
            ADD COLUMN head_age INTEGER;
          ''');
          await db.execute('''
            ALTER TABLE family_data
            ADD COLUMN head_occupation TEXT;
          ''');
          await db.execute('''
            ALTER TABLE family_data
            ADD COLUMN head_gross_monthly_income REAL;
          ''');
          await db.execute('''
            ALTER TABLE family_data
            ADD COLUMN head_mobile_number TEXT;
          ''');
        }
      },
    );
  }

  Future<int> insertFamily(Map<String, dynamic> family) async {
    final db = await database;
    return await db.insert('family_data', family);
  }

  Future<List<Map<String, dynamic>>> getFamilies() async {
    final db = await database;
    return await db.query('family_data', orderBy: 'id DESC');
  }

  Future<int> updateFamily(int id, Map<String, dynamic> family) async {
    final db = await database;
    return await db
        .update('family_data', family, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteFamily(int id) async {
    final db = await database;
    return await db.delete('family_data', where: 'id = ?', whereArgs: [id]);
  }
}
