import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/photo_model.dart';

class PhotoDB {
  static Database? database;

  // init table
  static Future<Database> initDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'photo.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE photos(id INTEGER PRIMARY KEY,albumId INTEGER, title TEXT, url TEXT, thumbnailUrl TEXT)",
        );
      },
      version: 1,
    );
    return database!;
  }

  static Future<Database> getDBConnect() async {
    if (database != null) {
      return database!;
    }
    return await initDatabase();
  }

  // 取得資料
  static Future<List<PhotoModel>> getPhotos() async {
    final Database db = await getDBConnect();
    final List<Map<String, dynamic>> maps = await db.query('photos');
    return List.generate(maps.length, (i) {
      return PhotoModel(
        id: maps[i]['id'],
        albumId: maps[i]['albumId'],
        title: maps[i]['title'],
        url: maps[i]['url'],
        thumbnailUrl: maps[i]['thumbnailUrl'],
      );
    });
  }

  // 新增
  static Future<void> addTodo(PhotoModel photo) async {
    final Database db = await getDBConnect();
    await db.insert(
      'photos',
      photo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 編輯
  static Future<void> updatePhoto(PhotoModel photo) async {
    final Database db = await getDBConnect();
    await db.update(
      'photos',
      photo.toJson(),
      where: "id = ?",
      whereArgs: [photo.id],
    );
  }

  // 刪除
  static Future<void> deletephoto(int id) async {
    final Database db = await getDBConnect();
    await db.delete(
      'photos',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
