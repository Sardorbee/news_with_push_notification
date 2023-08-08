import 'package:news_with_push_notification/services/models/fcm_response_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() {
    return instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'news.db');

    return await openDatabase(dbPath, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE news(
        newsId TEXT ,
        author TEXT,
        title TEXT,
        description TEXT,
        imageUrl TEXT,
        publishedAt TEXT,
        content TEXT
      )
    ''');
  }

  Future<void> insertProduct(FcmResponseModel news) async {
    final db = await database;
    await db.insert('news', news.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<FcmResponseModel?> getNewsById(String newsId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'news',
      where: 'newsId = ?',
      whereArgs: [newsId],
    );

    if (maps.isNotEmpty) {
      return FcmResponseModel.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<FcmResponseModel>> getAllnews() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('news');
    return List.generate(maps.length, (i) {
      return FcmResponseModel.fromJson(maps[i]);
    });
  }

  Future<void> updateProduct(FcmResponseModel news) async {
    final db = await database;
    await db.update(
      'news',
      news.toJson(),
      where: 'newsId = ?',
      whereArgs: [news.newsID],
    );
  }

  Future<void> deleteProduct(String publishedAt) async {
    final db = await database;
    await db.delete(
      'news',
      where: 'publishedAt = ?',
      whereArgs: [publishedAt],
    );
  }
}
