import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'therapy_event.dart';
part 'therapy_state.dart';

class TherapyBloc extends Bloc<TherapyEvent, TherapyState> {
  TherapyBloc() : super(TherapyInitial()) {
    on<TherapyEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
