import 'package:flutter_test/flutter_test.dart';
import 'package:momease/src/features/community/data/models/community_model.dart';
import 'package:momease/src/features/community/domain/entities/community_entity.dart';

void main() {
  const tCommunityModel = CommunityModel(
      id: 1,
      topic: 'topic',
      imageUrl: 'imageUrl',
      description: 'description',
      countPost: 10000);

  test('should be a subclass of CommunityEntity', () {
    // assert
    expect(tCommunityModel, isA<CommunityEntity>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is valid', () {
      // arrange
      final Map<String, dynamic> jsonMap = {
        'id': 1,
        'topic': 'topic',
        'imageUrl': 'imageUrl',
        'description': 'description',
        'countPost': 10000,
      };
      // act
      final result = CommunityModel.fromJson(jsonMap);
      // assert
      expect(result, tCommunityModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      // act
      final result = tCommunityModel.toJson();
      // assert
      final expectedMap = {
        'id': 1,
        'topic': 'topic',
        'imageUrl': 'imageUrl',
        'description': 'description',
        'countPost': 10000,
      };
      expect(result, expectedMap);
    });
  });
}
