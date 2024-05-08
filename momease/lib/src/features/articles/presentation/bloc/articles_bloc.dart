import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:momease/src/core/error/error_messages.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/core/usecases/usecase.dart';
import 'package:momease/src/features/articles/domain/entities/article_entity.dart';
import 'package:momease/src/features/articles/domain/usecases/get_article_list.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  List<ArticleEntity> articlesList = [];
  final GetArticleList getArticleList;

  ArticlesBloc({required this.getArticleList}) : super(ArticlesInitial()) {
    on<ArticlesEvent>((event, emit) async {
      if (event is FetchArticleList) {
        emit(ArticlesLoading());
        final result = await getArticleList(NoParams());
        result.fold(
          (failure) {
            var (statusCode, message) = _mapFailureToMessage(failure);
            emit(FailureState(statusCode, message));
          },
          (articlesList) {
            this.articlesList = articlesList;
            emit(ArticlesLoaded(articlesList));
          },
        );
      }
    });
  }

  (int, String) _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (CacheFailure):
        return (CACHE_FAILURE_CODE, CACHE_FAILURE_MESSAGE);
      default:
        return (UNKNOWN_FAILURE_CODE, 'Unexpected error');
    }
  }
}
