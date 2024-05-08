import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:momease/src/core/error/error_messages.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/core/usecases/usecase.dart';
import 'package:momease/src/features/therapy/domain/entities/therapy_entity.dart';
import 'package:momease/src/features/therapy/domain/usecases/get_therapy_list.dart';

part 'therapy_event.dart';
part 'therapy_state.dart';

class TherapyBloc extends Bloc<TherapyEvent, TherapyState> {
  List<TherapyEntity> therapyList = [];
  final GetTherapyList getTherapyList;

  TherapyBloc({required this.getTherapyList}) : super(TherapyInitial()) {
    on<TherapyEvent>((event, emit) async {
      if (event is FetchTherapyList) {
        emit(TherapyLoading());
        final result = await getTherapyList(NoParams());
        result.fold(
          (failure) {
            var (statusCode, message) = _mapFailureToMessage(failure);
            emit(FailureState(statusCode, message));
          },
          (therapyList) {
            this.therapyList = therapyList;
            emit(TherapyLoaded(therapyList));
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
