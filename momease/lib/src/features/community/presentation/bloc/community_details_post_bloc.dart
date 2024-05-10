import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:momease/src/core/error/error_messages.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/features/community/domain/entities/community_post_entity.dart';
import 'package:momease/src/features/community/domain/usecases/create_community_post.dart';
import 'package:momease/src/features/community/domain/usecases/get_community_post_list.dart';

part 'community_details_post_event.dart';
part 'community_details_post_state.dart';

class CommunityDetailsPostBloc
    extends Bloc<CommunityDetailsPostEvent, CommunityDetailsPostState> {
  List<CommunityPostEntity> communityPostList = [];
  final GetCommunityPostList getCommunityPostList;
  final CreateCommunityPost createCommunityPost;

  CommunityDetailsPostBloc(
      {required this.getCommunityPostList, required this.createCommunityPost})
      : super(CommunityDetailsPostInitial()) {
    on<CommunityDetailsPostEvent>((event, emit) async {
      if (event is FetchCommunityDetailsPost) {
        emit(CommunityDetailsPostLoading());
        final result = await getCommunityPostList(
            CommunityPostParams(topicId: event.topicId));
        await result.fold(
          (failure) async {
            var (statusCode, message) = _mapFailureToMessage(failure);
            emit(FailureState(statusCode, message));
          },
          (communityPostList) async {
            this.communityPostList = communityPostList;
            emit(CommunityDetailsPostLoaded(communityPostList));
          },
        );
      } else if (event is CreateCommunityDetailsPost) {
        emit(CommunityDetailsPostLoading());
        final postCreated = await createCommunityPost(
            CreateCommunityPostParams(communityPost: event.communityPost));
        final result = await getCommunityPostList(
            CommunityPostParams(topicId: event.communityPost.topicId));
        await postCreated.fold(
          (failure) async {
            var (statusCode, message) = _mapFailureToMessage(failure);
            emit(FailureState(statusCode, message));
          },
          (r) async {
            await result.fold(
              (failure) async {
                var (statusCode, message) = _mapFailureToMessage(failure);
                emit(FailureState(statusCode, message));
              },
              (communityPostList) async {
                this.communityPostList = communityPostList;
                emit(CommunityDetailsPostLoaded(communityPostList));
              },
            );
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
