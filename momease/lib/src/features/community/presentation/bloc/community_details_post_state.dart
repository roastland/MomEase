part of 'community_details_post_bloc.dart';

@immutable
abstract class CommunityDetailsPostState extends Equatable {
  const CommunityDetailsPostState();

  @override
  List<Object> get props => [];
}

class CommunityDetailsPostInitial extends CommunityDetailsPostState {}

class CommunityDetailsPostLoading extends CommunityDetailsPostState {}

class CommunityDetailsPostLoaded extends CommunityDetailsPostState {
  final List<CommunityPostEntity> communityPostList;

  const CommunityDetailsPostLoaded(this.communityPostList);

  @override
  List<Object> get props => [communityPostList];
}

class FailureState extends CommunityDetailsPostState {
  final int statusCode;
  final String message;

  const FailureState(this.statusCode, this.message);

  @override
  List<Object> get props => [statusCode, message];
}
