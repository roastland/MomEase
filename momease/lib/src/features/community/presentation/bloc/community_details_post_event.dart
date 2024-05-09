part of 'community_details_post_bloc.dart';

@immutable
abstract class CommunityDetailsPostEvent extends Equatable {
  const CommunityDetailsPostEvent();

  @override
  List<Object> get props => [];
}

class FetchCommunityDetailsPost extends CommunityDetailsPostEvent {
  final int topicId;

  const FetchCommunityDetailsPost(this.topicId);

  @override
  List<Object> get props => [topicId];
}

class CreateCommunityDetailsPost extends CommunityDetailsPostEvent {
  final CommunityPostEntity communityPost;

  const CreateCommunityDetailsPost(this.communityPost);

  @override
  List<Object> get props => [communityPost];
}
