import 'package:flutter/material.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:momease/src/core/error/exception.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/features/community/data/datasources/community_post_local_data_source.dart';
import 'package:momease/src/features/community/data/models/community_post_model.dart';
import 'package:momease/src/features/community/data/repositories/community_post_repository_impl.dart';

@GenerateNiceMocks([MockSpec<CommunityPostLocalDataSourceImpl>()])
import 'community_post_repository_impl_test.mocks.dart';

void main() {
  late CommunityPostRepositoryImpl repository;
  late MockCommunityPostLocalDataSourceImpl mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockCommunityPostLocalDataSourceImpl();
    repository =
        CommunityPostRepositoryImpl(localDataSource: mockLocalDataSource);
  });

  final tCommunityPost1 = CommunityPostModel(
      id: 1,
      topicId: 1,
      username: 'Claire B.',
      text:
          'I\'m feeling overwhelmed by breastfeeding. Any tips for establishing a good routine?',
      timestamp: DateTime(2024, 5, 1, 12),
      countComments: 12,
      countViews: 200);
  final tCommunityPost2 = CommunityPostModel(
      id: 2,
      topicId: 1,
      username: 'Claire B.',
      text:
          'I\'m feeling overwhelmed by breastfeeding. Any tips for establishing a good routine?',
      timestamp: DateTime(2024, 5, 1, 12),
      countComments: 12,
      countViews: 200);
  final tCommunityPost3 = CommunityPostModel(
      id: 3,
      topicId: 2,
      username: 'Claire B.',
      text:
          'I\'m feeling overwhelmed by breastfeeding. Any tips for establishing a good routine?',
      timestamp: DateTime(2024, 5, 1, 12),
      countComments: 12,
      countViews: 200);
  final tCommunityPostList = [tCommunityPost1, tCommunityPost2];

  group('getCommunityPostList', () {
    WidgetsFlutterBinding.ensureInitialized();
    test('should call getCommunityPostList from the local data source',
        () async {
      // arrange
      when(mockLocalDataSource.getCommunityPostList(1))
          .thenAnswer((_) async => tCommunityPostList);
      // act
      final result = await repository.getCommunityPostList(1);
      // assert
      verify(mockLocalDataSource.getCommunityPostList(1));
      expect(result, equals(Right(tCommunityPostList)));
    });

    test('should return CacheFailure when there is no cached data present',
        () async {
      // arrange
      when(mockLocalDataSource.getCommunityPostList(1))
          .thenThrow(CacheException());
      // act
      final result = await repository.getCommunityPostList(1);
      // assert
      expect(result, equals(Left(CacheFailure())));
    });
  });

  group('createCommunityPost', () {
    test('should call createCommunityPost from the local data source',
        () async {
      // arrange
      when(mockLocalDataSource.createCommunityPost(tCommunityPost3))
          .thenAnswer((_) async => tCommunityPost3.id);
      // act
      final result = await repository.createCommunityPost(tCommunityPost3);
      // assert
      verify(mockLocalDataSource.createCommunityPost(tCommunityPost3));
      expect(result, equals(Right(tCommunityPost3.id)));
    });

    test('should return CacheFailure when there is no cached data present',
        () async {
      // arrange
      when(mockLocalDataSource.createCommunityPost(tCommunityPost3))
          .thenThrow(CacheException());
      // act
      final result = await repository.createCommunityPost(tCommunityPost3);
      // assert
      expect(result, equals(Left(CacheFailure())));
    });
  });
}
