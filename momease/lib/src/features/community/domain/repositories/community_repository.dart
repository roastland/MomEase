import 'package:dartz/dartz.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/features/community/domain/entities/community_entity.dart';

abstract class CommunityRepository {
  Future<Either<Failure, List<CommunityEntity>>> getCommunityList();
}
