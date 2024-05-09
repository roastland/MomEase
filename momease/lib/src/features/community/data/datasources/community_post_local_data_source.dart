import 'package:momease/src/core/database/database.dart';
import 'package:momease/src/features/community/data/models/community_post_model.dart';

abstract class CommunityPostLocalDataSource {
  Future<List<CommunityPostModel>> getCommunityPostList(int topicId);
  Future<void> cacheCommunityPosts(
      List<CommunityPostModel> communityPostToCache);
  Future<int> createCommunityPost(CommunityPostModel communityPost);
}

class CommunityPostLocalDataSourceImpl implements CommunityPostLocalDataSource {
  late final AppDatabase _database;

  CommunityPostLocalDataSourceImpl({required AppDatabase database}) {
    _database = database;
  }

  @override
  Future<List<CommunityPostModel>> getCommunityPostList(int topicId) async {
    return await _database.readCommunityPostCertainTopic(topicId);
  }

  @override
  Future<void> cacheCommunityPosts(
      List<CommunityPostModel> communityPostToCache) async {
    for (CommunityPostModel communityPost in communityPostToCache) {
      await _database.createCommunityPost(communityPost);
    }
  }

  @override
  Future<int> createCommunityPost(CommunityPostModel communityPost) {
    return _database.createCommunityPost(communityPost);
  }
}
