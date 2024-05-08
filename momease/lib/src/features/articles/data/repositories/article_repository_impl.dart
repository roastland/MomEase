import 'package:dartz/dartz.dart';
import 'package:momease/src/core/error/exception.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/core/util/json_data_reader.dart';
import 'package:momease/src/features/articles/data/datasources/article_local_data_source.dart';
import 'package:momease/src/features/articles/data/models/article_model.dart';
import 'package:momease/src/features/articles/domain/entities/article_entity.dart';
import 'package:momease/src/features/articles/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleLocalDataSource localDataSource;

  ArticleRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<ArticleEntity>>> getArticleList() async {
    final Map<String, dynamic> jsonMap =
        await parseJsonFromAssets('./assets/json_data/article.json');
    final data = jsonMap['data'];
    final articleList = List.generate(data.length, (int index) => data[index])
        .map((article) => ArticleModel.fromJson(article))
        .toList();
    localDataSource.cacheArticles(articleList);

    try {
      final localArticle = await localDataSource.getArticleList();
      return Right(localArticle);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
