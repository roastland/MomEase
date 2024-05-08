part of 'exercise_bloc.dart';

@immutable
abstract class ExerciseState extends Equatable {
  const ExerciseState();

  @override
  List<Object> get props => [];
}

class ExerciseInitial extends ExerciseState {}

class ExerciseLoading extends ExerciseState {}

class ExerciseLoaded extends ExerciseState {
  final List<ExerciseEntity> exerciseList;

  const ExerciseLoaded(this.exerciseList);

  @override
  List<Object> get props => [exerciseList];
}

class FailureState extends ExerciseState {
  final int statusCode;
  final String message;

  const FailureState(this.statusCode, this.message);

  @override
  List<Object> get props => [statusCode, message];
}
