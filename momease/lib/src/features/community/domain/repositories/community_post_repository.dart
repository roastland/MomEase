import 'package:dartz/dartz.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/features/community/domain/entities/community_post_entity.dart';

abstract class CommunityPostRepository {
  Future<Either<Failure, List<CommunityPostEntity>>> getCommunityPostList(
      int topicId);
  Future<Either<Failure, int>> createCommunityPost(
      CommunityPostEntity communityPost);
}
