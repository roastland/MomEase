import 'package:dartz/dartz.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/features/therapy/domain/entities/therapy_entity.dart';

abstract class TherapyRepository {
  Future<Either<Failure, List<TherapyEntity>>> getTherapyList();
}
