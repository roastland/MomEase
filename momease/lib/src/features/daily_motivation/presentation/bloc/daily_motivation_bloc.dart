import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'daily_motivation_event.dart';
part 'daily_motivation_state.dart';

class DailyMotivationBloc extends Bloc<DailyMotivationEvent, DailyMotivationState> {
  DailyMotivationBloc() : super(DailyMotivationInitial()) {
    on<DailyMotivationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
