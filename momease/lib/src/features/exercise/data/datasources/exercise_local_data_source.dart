import 'package:momease/src/core/database/database.dart';
import 'package:momease/src/features/exercise/data/models/exercise_model.dart';

abstract class ExerciseLocalDataSource {
  Future<List<ExerciseModel>> getExerciseList();
  Future<void> cacheExercises(List<ExerciseModel> exerciseToCache);
}

class ExerciseLocalDataSourceImpl implements ExerciseLocalDataSource {
  late final AppDatabase _database;

  ExerciseLocalDataSourceImpl({required AppDatabase database}) {
    _database = database;
  }

  @override
  Future<List<ExerciseModel>> getExerciseList() async {
    return await _database.readAllExercise();
  }

  @override
  Future<void> cacheExercises(List<ExerciseModel> exerciseToCache) async {
    for (ExerciseModel exercise in exerciseToCache) {
      await _database.createExercise(exercise);
    }
  }
}
