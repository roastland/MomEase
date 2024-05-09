part of 'community_bloc.dart';

@immutable
abstract class CommunityState extends Equatable {
  const CommunityState();

  @override
  List<Object> get props => [];
}

class CommunityInitial extends CommunityState {}

class CommunityLoading extends CommunityState {}

class CommunityLoaded extends CommunityState {
  final List<CommunityEntity> communityList;

  const CommunityLoaded(this.communityList);

  @override
  List<Object> get props => [communityList];
}

class FailureState extends CommunityState {
  final int statusCode;
  final String message;

  const FailureState(this.statusCode, this.message);

  @override
  List<Object> get props => [statusCode, message];
}
