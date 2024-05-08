import 'package:dartz/dartz.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/core/usecases/usecase.dart';
import 'package:momease/src/features/articles/domain/entities/article_entity.dart';
import 'package:momease/src/features/articles/domain/repositories/article_repository.dart';

class GetArticleList extends UseCase<List<ArticleEntity>, NoParams> {
  final ArticleRepository repository;

  GetArticleList(this.repository);

  @override
  Future<Either<Failure, List<ArticleEntity>>> call(NoParams params) async {
    return await repository.getArticleList();
  }
}
