import 'package:flutter_test/flutter_test.dart';
import 'package:momease/src/features/articles/data/models/article_model.dart';

void main() {
  final tArticleModel = ArticleModel(
    id: 1,
    title: 'Understanding the Postpartum Blues: When Joy is Met with Tears',
    imageUrl: 'imageUrl',
    description: '',
    readingTime: 3,
    author: 'Dr. Cresya N.',
    publishedOn: DateTime(2024, 2, 22),
  );

  test('should be a subclass of ArticleEntity', () {
    // assert
    expect(tArticleModel, isA<ArticleModel>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is valid', () {
      // arrange
      final Map<String, dynamic> jsonMap = {
        'id': 1,
        'title':
            'Understanding the Postpartum Blues: When Joy is Met with Tears',
        'imageUrl': 'imageUrl',
        'description': '',
        'readingTime': 3,
        'author': 'Dr. Cresya N.',
        'publishedOn': '2024-02-22 00:00:00.000',
      };
      // act
      final result = ArticleModel.fromJson(jsonMap);
      // assert
      expect(result, tArticleModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      // act
      final result = tArticleModel.toJson();
      // assert
      final expectedMap = {
        'id': 1,
        'title':
            'Understanding the Postpartum Blues: When Joy is Met with Tears',
        'imageUrl': 'imageUrl',
        'description': '',
        'readingTime': 3,
        'author': 'Dr. Cresya N.',
        'publishedOn': '2024-02-22 00:00:00.000',
      };
      expect(result, expectedMap);
    });
  });
}
