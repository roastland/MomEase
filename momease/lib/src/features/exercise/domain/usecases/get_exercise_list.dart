import 'package:dartz/dartz.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/core/usecases/usecase.dart';
import 'package:momease/src/features/exercise/domain/entities/exercise_entity.dart';
import 'package:momease/src/features/exercise/domain/repositories/exercise_repository.dart';

class GetExerciseList implements UseCase<List<ExerciseEntity>, NoParams> {
  final ExerciseRepository repository;

  GetExerciseList(this.repository);

  @override
  Future<Either<Failure, List<ExerciseEntity>>> call(NoParams params) async {
    return await repository.getExerciseList();
  }
}
