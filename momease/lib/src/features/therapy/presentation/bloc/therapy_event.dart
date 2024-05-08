part of 'therapy_bloc.dart';

@immutable
abstract class TherapyEvent extends Equatable {
  const TherapyEvent();

  @override
  List<Object> get props => [];
}

class FetchTherapyList extends TherapyEvent {}
