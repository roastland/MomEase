part of 'exercise_bloc.dart';

@immutable
abstract class ExerciseEvent extends Equatable {
  const ExerciseEvent();

  @override
  List<Object> get props => [];
}

class FetchExerciseList extends ExerciseEvent {}
