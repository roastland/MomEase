import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:momease/src/core/error/error_messages.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/core/usecases/usecase.dart';
import 'package:momease/src/features/community/domain/entities/community_entity.dart';
import 'package:momease/src/features/community/domain/usecases/get_community_list.dart';

part 'community_event.dart';
part 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  List<CommunityEntity> communityList = [];
  final GetCommunityList getCommunityList;

  CommunityBloc({required this.getCommunityList}) : super(CommunityInitial()) {
    on<CommunityEvent>((event, emit) async {
      if (event is FetchCommunityList) {
        emit(CommunityLoading());
        final result = await getCommunityList(NoParams());
        result.fold(
          (failure) {
            var (statusCode, message) = _mapFailureToMessage(failure);
            emit(FailureState(statusCode, message));
          },
          (communityList) {
            this.communityList = communityList;
            emit(CommunityLoaded(communityList));
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
