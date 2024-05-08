import 'package:dartz/dartz.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/features/exercise/domain/entities/exercise_entity.dart';

abstract class ExerciseRepository {
  Future<Either<Failure, List<ExerciseEntity>>> getExerciseList();
}
