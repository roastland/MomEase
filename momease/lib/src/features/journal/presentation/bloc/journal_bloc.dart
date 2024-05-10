import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:momease/src/core/error/error_messages.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/core/usecases/usecase.dart';
import 'package:momease/src/features/journal/domain/entities/journal_entity.dart';
import 'package:momease/src/features/journal/domain/usecases/get_journal_entries.dart';

part 'journal_event.dart';
part 'journal_state.dart';

class JournalBloc extends Bloc<JournalEvent, JournalState> {
  List<JournalEntity> journalList = [];
  final GetJournalEntries getJournalList;

  JournalBloc({required this.getJournalList}) : super(JournalInitial()) {
    on<JournalEvent>((event, emit) async {
      if (event is FetchJournalList) {
        emit(JournalLoading());
        final result = await getJournalList(NoParams());
        result.fold(
          (failure) {
            var (statusCode, message) = _mapFailureToMessage(failure);
            emit(FailureState(statusCode, message));
          },
          (journalList) {
            this.journalList = journalList;
            emit(JournalLoaded(journalList));
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
