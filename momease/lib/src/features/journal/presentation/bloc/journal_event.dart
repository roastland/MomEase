part of 'journal_bloc.dart';

@immutable
abstract class JournalEvent extends Equatable {
  const JournalEvent();

  @override
  List<Object> get props => [];
}

class FetchJournalList extends JournalEvent {}
