import 'package:dartz/dartz.dart';
import 'package:momease/src/core/error/exception.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/core/util/json_data_reader.dart';
import 'package:momease/src/features/community/data/datasources/community_local_data_source.dart';
import 'package:momease/src/features/community/data/models/community_model.dart';
import 'package:momease/src/features/community/domain/entities/community_entity.dart';
import 'package:momease/src/features/community/domain/repositories/community_repository.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityLocalDataSource localDataSource;

  CommunityRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<CommunityEntity>>> getCommunityList() async {
    final Map<String, dynamic> jsonMap =
        await parseJsonFromAssets('./assets/json_data/community.json');
    final data = jsonMap['data'];
    final communityList = List.generate(data.length, (int index) => data[index])
        .map((community) => CommunityModel.fromJson(community))
        .toList();
    localDataSource.cacheCommunities(communityList);

    try {
      final localCommunity = await localDataSource.getCommunityList();
      return Right(localCommunity);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
