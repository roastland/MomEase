import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:momease/src/core/database/database.dart';
import 'package:momease/src/core/util/json_data_reader.dart';
import 'package:momease/src/features/community/data/datasources/community_local_data_source.dart';
import 'package:momease/src/features/community/data/models/community_model.dart';

@GenerateNiceMocks([MockSpec<AppDatabase>()])
import 'community_local_data_source_test.mocks.dart';

void main() {
  late CommunityLocalDataSourceImpl dataSource;
  late MockAppDatabase mockDatabase;

  setUp(() {
    mockDatabase = MockAppDatabase();
    dataSource = CommunityLocalDataSourceImpl(database: mockDatabase);
  });

  group('getCommunityList', () {
    test('should return a list of CommunityModel from the database', () async {
      WidgetsFlutterBinding.ensureInitialized();

      final Map<String, dynamic> jsonMap =
          await parseJsonFromAssets('./assets/json_data/community.json');
      final data = jsonMap['data'];
      final tCommunityList =
          List.generate(data.length, (int index) => data[index])
              .map((community) => CommunityModel.fromJson(community))
              .toList();

      // arrange
      when(mockDatabase.readAllCommunity())
          .thenAnswer((_) async => tCommunityList);
      // act
      final result = await dataSource.getCommunityList();
      // assert
      verify(mockDatabase.readAllCommunity());
      expect(result, equals(tCommunityList));
    });

    test(
        'should return an empty list when there is no community data in the database',
        () async {
      // arrange
      when(mockDatabase.readAllCommunity()).thenAnswer((_) async => []);
      // act
      final result = await dataSource.getCommunityList();
      // assert
      verify(mockDatabase.readAllCommunity());
      expect(result, equals([]));
    });
  });

  group('cacheCommunities', () {
    const tCommunity1 = CommunityModel(
      id: 1,
      topic: 'topic',
      imageUrl: 'imageUrl',
      description: 'description',
      countPost: 10000,
    );
    const tCommunity2 = CommunityModel(
      id: 2,
      topic: 'topic',
      imageUrl: 'imageUrl',
      description: 'description',
      countPost: 10000,
    );
    final tCommunityList = [tCommunity1, tCommunity2];

    test('should insert a CommunityModel into the database', () async {
      // arrange
      when(mockDatabase.updateCommunity(any))
          .thenAnswer((_) async => Future.value());
      // act
      await dataSource.cacheCommunities(tCommunityList);
      // assert
      verify(mockDatabase.createCommunity(tCommunity1));
      verify(mockDatabase.createCommunity(tCommunity2));
    });
  });
}
