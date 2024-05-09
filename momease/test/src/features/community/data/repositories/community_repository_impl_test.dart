import 'package:flutter/material.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:momease/src/core/error/exception.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/features/community/data/datasources/community_local_data_source.dart';
import 'package:momease/src/features/community/data/models/community_model.dart';
import 'package:momease/src/features/community/data/repositories/community_repository_impl.dart';

@GenerateNiceMocks([MockSpec<CommunityLocalDataSourceImpl>()])
import 'community_repository_impl_test.mocks.dart';

void main() {
  late CommunityRepositoryImpl repository;
  late MockCommunityLocalDataSourceImpl mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockCommunityLocalDataSourceImpl();
    repository = CommunityRepositoryImpl(localDataSource: mockLocalDataSource);
  });

  const tCommunity1 = CommunityModel(
    id: 1,
    topic: 'Breastfeeding',
    imageUrl: 'imageUrl',
    description: 'description',
    countPost: 10000,
  );
  const tCommunity2 = CommunityModel(
    id: 2,
    topic: 'Milk Pumping',
    imageUrl: 'imageUrl',
    description: 'description',
    countPost: 10000,
  );
  final tCommunityList = [tCommunity1, tCommunity2];

  group('getCommunityList', () {
    WidgetsFlutterBinding.ensureInitialized();

    test('should call getCommunityList from the local data source', () async {
      // arrange
      when(mockLocalDataSource.getCommunityList())
          .thenAnswer((_) async => tCommunityList);
      // act
      final result = await repository.getCommunityList();
      // assert
      verify(mockLocalDataSource.getCommunityList());
      expect(result, equals(Right(tCommunityList)));
    });

    test('should return CacheFailure when there is no cached data present',
        () async {
      // arrange
      when(mockLocalDataSource.getCommunityList()).thenThrow(CacheException());
      // act
      final result = await repository.getCommunityList();
      // assert
      expect(result, equals(Left(CacheFailure())));
    });
  });
}
