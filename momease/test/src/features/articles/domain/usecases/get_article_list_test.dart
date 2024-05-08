import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:momease/src/core/usecases/usecase.dart';
import 'package:momease/src/features/articles/domain/entities/article_entity.dart';
import 'package:momease/src/features/articles/domain/repositories/article_repository.dart';
import 'package:momease/src/features/articles/domain/usecases/get_article_list.dart';

@GenerateNiceMocks([MockSpec<ArticleRepository>()])
import 'get_article_list_test.mocks.dart';

void main() {
  late GetArticleList usecase;
  late MockArticleRepository mockArticleRepository;

  setUp(() {
    mockArticleRepository = MockArticleRepository();
    usecase = GetArticleList(mockArticleRepository);
  });

  final tArticleEntity1 = ArticleEntity(
    id: 1,
    title: 'Understanding the Postpartum Blues: When Joy is Met with Tears',
    imageUrl: 'imageUrl',
    readingTime: 3,
    author: 'Dr. Cresya N.',
    publishedOn: DateTime(2024, 2, 22),
  );
  final tArticleEntity2 = ArticleEntity(
    id: 2,
    title: 'Building a Happy Haven: Nurturing Joy for Mom and Baby',
    imageUrl: 'imageUrl',
    readingTime: 5,
    author: 'Dr. Cresya N.',
    publishedOn: DateTime(2024, 2, 22),
  );
  final tArticleList = [tArticleEntity1, tArticleEntity2];

  test('should get article list from the repository', () async {
    // arrange
    when(mockArticleRepository.getArticleList())
        .thenAnswer((_) async => Right(tArticleList));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, Right(tArticleList));
    verify(mockArticleRepository.getArticleList());
    verifyNoMoreInteractions(mockArticleRepository);
  });
}
