import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:momease/src/core/database/database.dart';
import 'package:momease/src/core/util/json_data_reader.dart';
import 'package:momease/src/features/community/data/datasources/community_post_local_data_source.dart';
import 'package:momease/src/features/community/data/models/community_post_model.dart';

@GenerateNiceMocks([MockSpec<AppDatabase>()])
import 'community_post_local_data_source_test.mocks.dart';

void main() {
  late CommunityPostLocalDataSourceImpl dataSource;
  late MockAppDatabase mockDatabase;

  setUp(() {
    mockDatabase = MockAppDatabase();
    dataSource = CommunityPostLocalDataSourceImpl(database: mockDatabase);
  });

  group('getCommunityPostList', () {
    test('should return a list of CommunityPostModel from the database',
        () async {
      WidgetsFlutterBinding.ensureInitialized();

      final Map<String, dynamic> jsonMap =
          await parseJsonFromAssets('./assets/json_data/community_post.json');
      final data = jsonMap['data'];
      final tCommunityPostList = List.generate(
              data.length, (int index) => data[index])
          .map((communityPost) => CommunityPostModel.fromJson(communityPost))
          .toList();

      // arrange
      when(mockDatabase.readCommunityPostCertainTopic(1))
          .thenAnswer((_) async => tCommunityPostList);
      // act
      final result = await dataSource.getCommunityPostList(1);
      // assert
      verify(mockDatabase.readCommunityPostCertainTopic(1));
      expect(result, equals(tCommunityPostList));
    });

    test(
        'should return an empty list when there is no community post data in the database',
        () async {
      // arrange
      when(mockDatabase.readCommunityPostCertainTopic(1))
          .thenAnswer((_) async => []);
      // act
      final result = await dataSource.getCommunityPostList(1);
      // assert
      verify(mockDatabase.readCommunityPostCertainTopic(1));
      expect(result, equals([]));
    });
  });

  group('cacheCommunityPosts', () {
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
    final tCommunityPostList = [tCommunityPost1, tCommunityPost2];

    test('should insert a CommunityPostModel into the database', () async {
      // arrange
      when(mockDatabase.updateCommunityPost(any))
          .thenAnswer((_) async => Future.value());
      // act
      await dataSource.cacheCommunityPosts(tCommunityPostList);
      // assert
      verify(mockDatabase.createCommunityPost(tCommunityPost1));
      verify(mockDatabase.createCommunityPost(tCommunityPost2));
    });
  });

  group('createCommunityPost', () {
    final tCommunityPost = CommunityPostModel(
        id: 3,
        topicId: 2,
        username: 'Claire B.',
        text:
            'I\'m feeling overwhelmed by breastfeeding. Any tips for establishing a good routine?',
        timestamp: DateTime(2024, 5, 1, 12),
        countComments: 12,
        countViews: 200);

    test('should insert a CommunityPostModel into the database', () async {
      // arrange
      when(mockDatabase.createCommunityPost(tCommunityPost))
          .thenAnswer((_) async => Future.value(tCommunityPost.id));
      // act
      final result = await dataSource.createCommunityPost(tCommunityPost);
      // assert
      verify(mockDatabase.createCommunityPost(tCommunityPost));
      expect(result, equals(tCommunityPost.id));
    });
  });
}
