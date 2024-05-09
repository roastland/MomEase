import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/core/usecases/usecase.dart';
import 'package:momease/src/features/community/domain/entities/community_post_entity.dart';
import 'package:momease/src/features/community/domain/repositories/community_post_repository.dart';

class GetCommunityPostList
    implements UseCase<List<CommunityPostEntity>, CommunityPostParams> {
  final CommunityPostRepository repository;

  GetCommunityPostList(this.repository);

  @override
  Future<Either<Failure, List<CommunityPostEntity>>> call(
      CommunityPostParams params) async {
    return await repository.getCommunityPostList(params.topicId);
  }
}

class CommunityPostParams extends Equatable {
  final int topicId;

  const CommunityPostParams({required this.topicId});

  @override
  List<Object> get props => [topicId];
}
