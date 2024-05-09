import 'package:momease/src/core/database/database.dart';
import 'package:momease/src/features/community/data/models/community_model.dart';

abstract class CommunityLocalDataSource {
  Future<List<CommunityModel>> getCommunityList();
  Future<void> cacheCommunities(List<CommunityModel> communityToCache);
}

class CommunityLocalDataSourceImpl implements CommunityLocalDataSource {
  late final AppDatabase _database;

  CommunityLocalDataSourceImpl({required AppDatabase database}) {
    _database = database;
  }

  @override
  Future<List<CommunityModel>> getCommunityList() async {
    return await _database.readAllCommunity();
  }

  @override
  Future<void> cacheCommunities(List<CommunityModel> communityToCache) async {
    for (CommunityModel community in communityToCache) {
      await _database.createCommunity(community);
    }
  }
}
