import 'package:flutter/material.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:momease/src/core/error/exception.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/features/articles/data/datasources/article_local_data_source.dart';
import 'package:momease/src/features/articles/data/models/article_model.dart';
import 'package:momease/src/features/articles/data/repositories/article_repository_impl.dart';

@GenerateNiceMocks([MockSpec<ArticleLocalDataSourceImpl>()])
import 'article_repository_impl_test.mocks.dart';

void main() {
  late ArticleRepositoryImpl repository;
  late MockArticleLocalDataSourceImpl mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockArticleLocalDataSourceImpl();
    repository = ArticleRepositoryImpl(
      localDataSource: mockLocalDataSource,
    );
  });

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

  group('getArticleList', () {
    WidgetsFlutterBinding.ensureInitialized();

    test('should call getArticleList from the local data source', () async {
      // arrange
      when(mockLocalDataSource.getArticleList())
          .thenAnswer((_) async => tArticleList);
      // act
      final result = await repository.getArticleList();
      // assert
      verify(mockLocalDataSource.getArticleList());
      expect(result, equals(Right(tArticleList)));
    });

    test('should return CacheFailure when there is no cached data present',
        () async {
      // arrange
      when(mockLocalDataSource.getArticleList()).thenThrow(CacheException());
      // act
      final result = await repository.getArticleList();
      // assert
      expect(result, equals(Left(CacheFailure())));
    });
  });
}
