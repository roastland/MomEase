part of 'therapy_bloc.dart';

@immutable
abstract class TherapyState extends Equatable {
  const TherapyState();

  @override
  List<Object> get props => [];
}

class TherapyInitial extends TherapyState {}

class TherapyLoading extends TherapyState {}

class TherapyLoaded extends TherapyState {
  final List<TherapyEntity> therapyList;

  const TherapyLoaded(this.therapyList);

  @override
  List<Object> get props => [therapyList];
}

class FailureState extends TherapyState {
  final int statusCode;
  final String message;

  const FailureState(this.statusCode, this.message);

  @override
  List<Object> get props => [statusCode, message];
}
