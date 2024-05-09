import 'package:dartz/dartz.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/core/usecases/usecase.dart';
import 'package:momease/src/features/community/domain/entities/community_entity.dart';
import 'package:momease/src/features/community/domain/repositories/community_repository.dart';

class GetCommunityList implements UseCase<List<CommunityEntity>, NoParams> {
  final CommunityRepository repository;

  GetCommunityList(this.repository);

  @override
  Future<Either<Failure, List<CommunityEntity>>> call(NoParams params) async {
    return await repository.getCommunityList();
  }
}
