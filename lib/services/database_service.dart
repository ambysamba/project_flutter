import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  Future<List<String>> getAllArticleIds() async {
    final db = await database;
    final result = await db.query('articles', columns: ['id']);
    return result.map((e) => e['id'] as String).toList();
  }

  Future<void> deleteArticleById(String id) async {
    final db = await database;
    await db.delete('articles', where: 'id = ?', whereArgs: [id]);
  }

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'favoris.db'),
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favoris(
            id TEXT PRIMARY KEY
          )
        ''');
        await db.execute('''
          CREATE TABLE articles(
            id TEXT PRIMARY KEY,
            title TEXT,
            description TEXT,
            url TEXT,
            imageUrl TEXT,
            publishedAt TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS articles(
              id TEXT PRIMARY KEY,
              title TEXT,
              description TEXT,
              url TEXT,
              imageUrl TEXT,
              publishedAt TEXT
            )
          ''');
        }
      },
    );
  }

  Future<void> insertArticle(Map<String, dynamic> article) async {
    final db = await database;
    await db.insert('articles', article,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getArticleById(String id) async {
    final db = await database;
    final result = await db.query('articles', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<void> insertFavori(String id) async {
    final db = await database;
    await db.insert('favoris', {'id': id},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteFavori(String id) async {
    final db = await database;
    await db.delete('favoris', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<String>> getFavoris() async {
    final db = await database;
    final result = await db.query('favoris');
    return result.map((e) => e['id'] as String).toList();
  }
}
