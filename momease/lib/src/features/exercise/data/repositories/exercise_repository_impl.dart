import 'package:dartz/dartz.dart';
import 'package:momease/src/core/error/exception.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/core/util/json_data_reader.dart';
import 'package:momease/src/features/exercise/data/datasources/exercise_local_data_source.dart';
import 'package:momease/src/features/exercise/data/models/exercise_model.dart';
import 'package:momease/src/features/exercise/domain/entities/exercise_entity.dart';
import 'package:momease/src/features/exercise/domain/repositories/exercise_repository.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  final ExerciseLocalDataSource localDataSource;

  ExerciseRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<ExerciseEntity>>> getExerciseList() async {
    final Map<String, dynamic> jsonMap =
        await parseJsonFromAssets('./assets/json_data/exercise.json');
    final data = jsonMap['data'];
    final exerciseList = List.generate(data.length, (int index) => data[index])
        .map((exercise) => ExerciseModel.fromJson(exercise))
        .toList();
    localDataSource.cacheExercises(exerciseList);

    try {
      final localExercise = await localDataSource.getExerciseList();
      return Right(localExercise);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
