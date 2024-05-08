import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:momease/src/core/database/database.dart';
import 'package:momease/src/core/util/json_data_reader.dart';
import 'package:momease/src/features/articles/data/datasources/article_local_data_source.dart';
import 'package:momease/src/features/articles/data/models/article_model.dart';

@GenerateNiceMocks([MockSpec<AppDatabase>()])
import 'article_local_data_source_test.mocks.dart';

void main() {
  late ArticleLocalDataSourceImpl dataSource;
  late MockAppDatabase mockDatabase;

  setUp(() {
    mockDatabase = MockAppDatabase();
    dataSource = ArticleLocalDataSourceImpl(database: mockDatabase);
  });

  group('getArticleList', () {
    test('should return a list of ArticleModel from the database', () async {
      WidgetsFlutterBinding.ensureInitialized();

      final Map<String, dynamic> jsonMap =
          await parseJsonFromAssets('./assets/json_data/article.json');
      final data = jsonMap['data'];
      final tArticleList =
          List.generate(data.length, (int index) => data[index])
              .map((article) => ArticleModel.fromJson(article))
              .toList();

      // arrange
      when(mockDatabase.readAllArticle()).thenAnswer((_) async => tArticleList);
      // act
      final result = await dataSource.getArticleList();
      // assert
      verify(mockDatabase.readAllArticle());
      expect(result, equals(tArticleList));
    });

    test(
        'should return an empty list when there is no article data in the database',
        () async {
      // arrange
      when(mockDatabase.readAllArticle()).thenAnswer((_) async => []);
      // act
      final result = await dataSource.getArticleList();
      // assert
      verify(mockDatabase.readAllArticle());
      expect(result, equals([]));
    });
  });

  group('cacheArticles', () {
    final tArticle1 = ArticleModel(
      id: 1,
      title: 'Understanding the Postpartum Blues: When Joy is Met with Tears',
      imageUrl: 'imageUrl',
      description: '',
      readingTime: 3,
      author: 'Dr. Cresya N.',
      publishedOn: DateTime(2024, 2, 22),
    );
    final tArticle2 = ArticleModel(
      id: 2,
      title: 'Building a Happy Haven: Nurturing Joy for Mom and Baby',
      imageUrl: 'imageUrl',
      description: '',
      readingTime: 5,
      author: 'Dr. Cresya N.',
      publishedOn: DateTime(2024, 2, 22),
    );
    final tArticleList = [tArticle1, tArticle2];

    test('should insert an ArticleModel into the database', () async {
      // arrange
      when(mockDatabase.updateArticle(any))
          .thenAnswer((_) async => Future.value());
      // act
      await dataSource.cacheArticles(tArticleList);
      // assert
      verify(mockDatabase.createArticle(tArticle1));
      verify(mockDatabase.createArticle(tArticle2));
    });
  });
}
