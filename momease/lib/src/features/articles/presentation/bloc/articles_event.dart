part of 'articles_bloc.dart';

@immutable
abstract class ArticlesEvent extends Equatable {
  const ArticlesEvent();

  @override
  List<Object> get props => [];
}

class FetchArticleList extends ArticlesEvent {}
