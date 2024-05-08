import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:momease/src/core/error/error_messages.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/core/usecases/usecase.dart';
import 'package:momease/src/features/exercise/domain/entities/exercise_entity.dart';
import 'package:momease/src/features/exercise/domain/usecases/get_exercise_list.dart';

part 'exercise_event.dart';
part 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  List<ExerciseEntity> exerciseList = [];
  final GetExerciseList getExerciseList;

  ExerciseBloc({required this.getExerciseList}) : super(ExerciseInitial()) {
    on<ExerciseEvent>((event, emit) async {
      if (event is FetchExerciseList) {
        emit(ExerciseLoading());
        final result = await getExerciseList(NoParams());
        result.fold(
          (failure) {
            var (statusCode, message) = _mapFailureToMessage(failure);
            emit(FailureState(statusCode, message));
          },
          (exerciseList) {
            this.exerciseList = exerciseList;
            emit(ExerciseLoaded(exerciseList));
          },
        );
      }
    });
  }
}

(int, String) _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case const (CacheFailure):
      return (CACHE_FAILURE_CODE, CACHE_FAILURE_MESSAGE);
    default:
      return (UNKNOWN_FAILURE_CODE, 'Unexpected error');
  }
}
