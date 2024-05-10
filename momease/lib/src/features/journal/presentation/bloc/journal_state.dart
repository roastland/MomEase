part of 'journal_bloc.dart';

@immutable
abstract class JournalState extends Equatable {
  const JournalState();

  @override
  List<Object> get props => [];
}

class JournalInitial extends JournalState {}

class JournalLoading extends JournalState {}

class JournalLoaded extends JournalState {
  final List<JournalEntity> journalList;

  const JournalLoaded(this.journalList);

  @override
  List<Object> get props => [journalList];
}

class FailureState extends JournalState {
  final int statusCode;
  final String message;

  const FailureState(this.statusCode, this.message);

  @override
  List<Object> get props => [statusCode, message];
}
