part of 'articles_bloc.dart';

@immutable
abstract class ArticlesState extends Equatable {
  const ArticlesState();

  @override
  List<Object> get props => [];
}

class ArticlesInitial extends ArticlesState {}

class ArticlesLoading extends ArticlesState {}

class ArticlesLoaded extends ArticlesState {
  final List<ArticleEntity> articlesList;

  const ArticlesLoaded(this.articlesList);

  @override
  List<Object> get props => [articlesList];
}

class FailureState extends ArticlesState {
  final int statusCode;
  final String message;

  const FailureState(this.statusCode, this.message);

  @override
  List<Object> get props => [statusCode, message];
}
