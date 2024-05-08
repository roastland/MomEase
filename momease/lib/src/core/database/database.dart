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

  Future<int> deleteAllTherapy() async {
    final db = await instance.database;
    return await db.delete('therapy');
  }

  Future<int> deleteAllExercise() async {
    final db = await instance.database;
    return await db.delete('exercise');
  }

  Future deleteAllTable() async {
    await deleteAllTherapy();
    await deleteAllExercise();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
