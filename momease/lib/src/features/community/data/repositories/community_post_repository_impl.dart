import 'package:dartz/dartz.dart';
import 'package:momease/src/core/error/exception.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/core/util/json_data_reader.dart';
import 'package:momease/src/features/community/data/datasources/community_post_local_data_source.dart';
import 'package:momease/src/features/community/data/models/community_post_model.dart';
import 'package:momease/src/features/community/domain/entities/community_post_entity.dart';
import 'package:momease/src/features/community/domain/repositories/community_post_repository.dart';

class CommunityPostRepositoryImpl implements CommunityPostRepository {
  final CommunityPostLocalDataSource localDataSource;

  CommunityPostRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<CommunityPostEntity>>> getCommunityPostList(
      int topicId) async {
    final Map<String, dynamic> jsonMap =
        await parseJsonFromAssets('./assets/json_data/community_post.json');
    final data = jsonMap['data'];
    final communityPostList =
        List.generate(data.length, (int index) => data[index])
            .map((communityPost) => CommunityPostModel.fromJson(communityPost))
            .toList();
    localDataSource.cacheCommunityPosts(communityPostList);

    try {
      final localCommunityPost =
          await localDataSource.getCommunityPostList(topicId);
      return Right(localCommunityPost);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, int>> createCommunityPost(
      CommunityPostEntity communityPost) async {
    try {
      final postId = await localDataSource
          .createCommunityPost(communityPost as CommunityPostModel);
      return Right(postId);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
