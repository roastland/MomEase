part of 'community_bloc.dart';

@immutable
abstract class CommunityEvent extends Equatable {
  const CommunityEvent();

  @override
  List<Object> get props => [];
}

class FetchCommunityList extends CommunityEvent {}
