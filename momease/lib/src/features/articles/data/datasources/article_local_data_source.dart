import 'package:momease/src/core/database/database.dart';
import 'package:momease/src/features/articles/data/models/article_model.dart';

abstract class ArticleLocalDataSource {
  Future<List<ArticleModel>> getArticleList();
  Future<void> cacheArticles(List<ArticleModel> articleToCache);
}

class ArticleLocalDataSourceImpl implements ArticleLocalDataSource {
  late final AppDatabase _database;

  ArticleLocalDataSourceImpl({required AppDatabase database}) {
    _database = database;
  }

  @override
  Future<List<ArticleModel>> getArticleList() async {
    return await _database.readAllArticle();
  }

  @override
  Future<void> cacheArticles(List<ArticleModel> articleToCache) async {
    for (ArticleModel article in articleToCache) {
      await _database.createArticle(article);
    }
  }
}
