import 'package:flutter_test/flutter_test.dart';
import 'package:momease/src/features/community/data/models/community_post_model.dart';
import 'package:momease/src/features/community/domain/entities/community_post_entity.dart';

void main() {
  final tCommunityPostModel = CommunityPostModel(
      id: 1,
      topicId: 1,
      username: 'Claire B.',
      text:
          'I\'m feeling overwhelmed by breastfeeding. Any tips for establishing a good routine?',
      timestamp: DateTime(2024, 5, 1, 12),
      countComments: 12,
      countViews: 200);

  test('should be a subclass of CommunityPostEntity', () {
    // assert
    expect(tCommunityPostModel, isA<CommunityPostEntity>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is valid', () {
      // arrange
      final Map<String, dynamic> jsonMap = {
        "id": 1,
        "topicId": 1,
        "username": "Claire B.",
        "text":
            "I'm feeling overwhelmed by breastfeeding. Any tips for establishing a good routine?",
        "timestamp": "2024-05-01 12:00:00.000",
        "countComments": 12,
        "countViews": 200
      };
      // act
      final result = CommunityPostModel.fromJson(jsonMap);
      // assert
      expect(result, tCommunityPostModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      // act
      final result = tCommunityPostModel.toJson();
      // assert
      final expectedMap = {
        "id": 1,
        "topicId": 1,
        "username": "Claire B.",
        "text":
            "I'm feeling overwhelmed by breastfeeding. Any tips for establishing a good routine?",
        "timestamp": "2024-05-01 12:00:00.000",
        "countComments": 12,
        "countViews": 200
      };
      expect(result, expectedMap);
    });
  });
}
