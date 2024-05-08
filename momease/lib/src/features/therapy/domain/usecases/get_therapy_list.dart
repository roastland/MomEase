import 'package:dartz/dartz.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/core/usecases/usecase.dart';
import 'package:momease/src/features/therapy/domain/entities/therapy_entity.dart';
import 'package:momease/src/features/therapy/domain/repositories/therapy_repository.dart';

class GetTherapyList implements UseCase<List<TherapyEntity>, NoParams> {
  final TherapyRepository repository;

  GetTherapyList(this.repository);

  @override
  Future<Either<Failure, List<TherapyEntity>>> call(NoParams params) async {
    return await repository.getTherapyList();
  }
}
