import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'professional_help_event.dart';
part 'professional_help_state.dart';

class ProfessionalHelpBloc extends Bloc<ProfessionalHelpEvent, ProfessionalHelpState> {
  ProfessionalHelpBloc() : super(ProfessionalHelpInitial()) {
    on<ProfessionalHelpEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
