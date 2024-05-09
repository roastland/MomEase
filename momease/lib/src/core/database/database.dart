import 'package:momease/src/features/articles/data/models/article_model.dart';
import 'package:momease/src/features/community/data/models/community_model.dart';
import 'package:momease/src/features/community/data/models/community_post_model.dart';
import 'package:momease/src/features/exercise/data/models/exercise_model.dart';
import 'package:momease/src/features/therapy/data/models/therapy_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();

  static Database? _database;
  AppDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('appdata.db');

    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    String path = await getDatabasesPath();
    int dbVersion = dbScripts.length;

    return openDatabase(
      join(path, fileName),
      version: dbVersion,
      onCreate: (db, version) async {
        for (int i = 1; i <= version; i++) {
          await db.execute(dbScripts[i]!);
        }
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        for (int i = oldVersion + 1; i <= newVersion; i++) {
          await db.execute(dbScripts[i]!);
        }
      },
    );
  }

  final Map<int, String> dbScripts = {
    1: '''
      CREATE TABLE therapy (
        id INTEGER NOT NULL,
        title TEXT NOT NULL,
        imageUrl TEXT NOT NULL,
        description TEXT,
        PRIMARY KEY (id)
      )
    ''',
    2: '''
      CREATE TABLE exercise (
        id INTEGER NOT NULL,
        title TEXT NOT NULL,
        imageUrl TEXT NOT NULL,
        description TEXT,
        PRIMARY KEY (id)
      )
    ''',
    3: '''
      CREATE TABLE article (
        id INTEGER NOT NULL,
        title TEXT NOT NULL,
        imageUrl TEXT NOT NULL,
        description TEXT,
        readingTime INTEGER NOT NULL,
        author TEXT NOT NULL,
        publishedOn TEXT NOT NULL,
        PRIMARY KEY (id)
      )
    ''',
    4: '''
      CREATE TABLE community (
        id INTEGER NOT NULL,
        topic TEXT NOT NULL,
        imageUrl TEXT NOT NULL,
        description TEXT NOT NULL,
        countPost INTEGER NOT NULL,
        PRIMARY KEY (id)
      )
    ''',
    5: '''
      CREATE TABLE community_post (
        id INTEGER NOT NULL,
        topicId INTEGER NOT NULL,
        username TEXT NOT NULL,
        text TEXT NOT NULL,
        timestamp TEXT NOT NULL,
        countComments INTEGER NOT NULL,
        countViews INTEGER NOT NULL,
        PRIMARY KEY (id),
        FOREIGN KEY (topicId) 
          REFERENCES community (id)
            ON DELETE CASCADE
      )
    '''
  };

  Future<int> createTherapy(TherapyModel therapy) async {
    final db = await instance.database;
    return await db.insert('therapy', therapy.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> createExercise(ExerciseModel exercise) async {
    final db = await instance.database;
    return await db.insert('exercise', exercise.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> createArticle(ArticleModel article) async {
    final db = await instance.database;
    return await db.insert('article', article.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> createCommunity(CommunityModel community) async {
    final db = await instance.database;
    return await db.insert('community', community.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> createCommunityPost(CommunityPostModel communityPost) async {
    final db = await instance.database;
    return await db.insert('community_post', communityPost.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<TherapyModel>> readAllTherapy() async {
    final db = await instance.database;
    final maps = await db.query('therapy');
    return maps.map((json) => TherapyModel.fromJson(json)).toList();
  }

  Future<List<ExerciseModel>> readAllExercise() async {
    final db = await instance.database;
    final maps = await db.query('exercise');
    return maps.map((json) => ExerciseModel.fromJson(json)).toList();
  }

  Future<List<ArticleModel>> readAllArticle() async {
    final db = await instance.database;
    final maps = await db.query('article');
    return maps.map((json) => ArticleModel.fromJson(json)).toList();
  }

  Future<List<CommunityModel>> readAllCommunity() async {
    final db = await instance.database;
    final maps = await db.query('community');
    return maps.map((json) => CommunityModel.fromJson(json)).toList();
  }

  Future<List<CommunityPostModel>> readAllCommunityPost() async {
    final db = await instance.database;
    final maps = await db.query('community_post');
    return maps.map((json) => CommunityPostModel.fromJson(json)).toList();
  }

  Future<List<CommunityPostModel>> readCommunityPostCertainTopic(
      int topicId) async {
    final db = await instance.database;
    final maps = await db.query(
      'community_post',
      where: 'topicId = ?',
      whereArgs: [topicId],
    );
    return maps.map((json) => CommunityPostModel.fromJson(json)).toList();
  }

  Future updateTherapy(TherapyModel therapy) async {
    final db = await instance.database;
    await db.update(
      'therapy',
      therapy.toJson(),
      where: 'id = ?',
      whereArgs: [therapy.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future updateExercise(ExerciseModel exercise) async {
    final db = await instance.database;
    await db.update(
      'exercise',
      exercise.toJson(),
      where: 'id = ?',
      whereArgs: [exercise.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future updateArticle(ArticleModel article) async {
    final db = await instance.database;
    await db.update(
      'article',
      article.toJson(),
      where: 'id = ?',
      whereArgs: [article.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future updateCommunity(CommunityModel community) async {
    final db = await instance.database;
    await db.update(
      'community',
      community.toJson(),
      where: 'id = ?',
      whereArgs: [community.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future updateCommunityPost(CommunityPostModel communityPost) async {
    final db = await instance.database;
    await db.update(
      'community_post',
      communityPost.toJson(),
      where: 'id = ?',
      whereArgs: [communityPost.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteSelectedTherapy(int id) async {
    final db = await instance.database;
    return await db.delete(
      'therapy',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteSelectedExercise(int id) async {
    final db = await instance.database;
    return await db.delete(
      'exercise',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteSelectedArticle(int id) async {
    final db = await instance.database;
    return await db.delete(
      'article',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteSelectedCommunity(int id) async {
    final db = await instance.database;
    return await db.delete(
      'community',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteSelectedCommunityPost(int id) async {
    final db = await instance.database;
    return await db.delete(
      'community_post',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllTherapy() async {
    final db = await instance.database;
    return await db.delete('therapy');
  }

  Future<int> deleteAllExercise() async {
    final db = await instance.database;
    return await db.delete('exercise');
  }

  Future<int> deleteAllArticle() async {
    final db = await instance.database;
    return await db.delete('article');
  }

  Future<int> deleteAllCommunity() async {
    final db = await instance.database;
    return await db.delete('community');
  }

  Future<int> deleteAllCommunityPost() async {
    final db = await instance.database;
    return await db.delete('community_post');
  }

  Future deleteAllTable() async {
    await deleteAllTherapy();
    await deleteAllExercise();
    await deleteAllArticle();
    await deleteAllCommunity();
    await deleteAllCommunityPost();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
