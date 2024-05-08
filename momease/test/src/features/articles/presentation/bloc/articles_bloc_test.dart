import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:momease/src/core/error/error_messages.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/core/usecases/usecase.dart';
import 'package:momease/src/features/articles/domain/entities/article_entity.dart';
import 'package:momease/src/features/articles/domain/usecases/get_article_list.dart';
import 'package:momease/src/features/articles/presentation/bloc/articles_bloc.dart';

@GenerateNiceMocks([MockSpec<GetArticleList>()])
import 'articles_bloc_test.mocks.dart';

void main() {
  late ArticlesBloc bloc;
  late MockGetArticleList mockGetArticleList;

  setUp(() {
    mockGetArticleList = MockGetArticleList();
    bloc = ArticlesBloc(getArticleList: mockGetArticleList);
  });

  test('initialState should be ArticlesInitial', () {
    // assert
    expect(bloc.state, equals(ArticlesInitial()));
  });

  group('FetchArticlesList', () {
    final tArticleEntity1 = ArticleEntity(
      id: 1,
      title: 'Understanding the Postpartum Blues: When Joy is Met with Tears',
      imageUrl: 'imageUrl',
      description: '',
      readingTime: 3,
      author: 'Dr. Cresya N.',
      publishedOn: DateTime(2024, 2, 22),
    );
    final tArticleEntity2 = ArticleEntity(
      id: 2,
      title: 'Building a Happy Haven: Nurturing Joy for Mom and Baby',
      imageUrl: 'imageUrl',
      description: '',
      readingTime: 5,
      author: 'Dr. Cresya N.',
      publishedOn: DateTime(2024, 2, 22),
    );
    final tArticleList = [tArticleEntity1, tArticleEntity2];

    test('should get articles list from the usecase', () async {
      // arrange
      when(mockGetArticleList(any))
          .thenAnswer((_) async => Right(tArticleList));
      // act
      bloc.add(FetchArticleList());
      await untilCalled(mockGetArticleList(any));
      // assert
      verify(mockGetArticleList(NoParams()));
    });

    test(
        'should emit [ArticlesLoading, ArticlesLoaded] when data is gotten successfully',
        () async {
      // arrange
      when(mockGetArticleList(any))
          .thenAnswer((_) async => Right(tArticleList));
      // assert later
      final expected = [
        ArticlesLoading(),
        ArticlesLoaded(tArticleList),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(FetchArticleList());
    });

    test('should emit [ArticlesLoading, FailureState] when getting data fails',
        () async {
      // arrange
      when(mockGetArticleList(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      // assert later
      final expected = [
        ArticlesLoading(),
        const FailureState(CACHE_FAILURE_CODE, CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(FetchArticleList());
    });

    test(
        'should emit [ArticlesLoading, FailureState] with proper error message',
        () async {
      // arrange
      when(mockGetArticleList(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      // assert later
      final expected = [
        ArticlesLoading(),
        const FailureState(CACHE_FAILURE_CODE, CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(FetchArticleList());
    });
  });
}
