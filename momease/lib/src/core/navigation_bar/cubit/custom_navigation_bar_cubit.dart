import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'custom_navigation_bar_state.dart';

class CustomNavigationBarCubit extends Cubit<CustomNavigationBarState> {
  CustomNavigationBarCubit() : super(CustomNavigationBarHome());

  CustomNavigationBarState get currentState => state;
  late int currentIndex = stateToIndex(currentState);
  late final List<int> pagesStack = [currentIndex];

  void pushPage(int index) {
    if (currentIndex != index) {
      pagesStack.add(index);
      currentIndex = index;
      emit(indexToState(index));
    }
  }

  CustomNavigationBarState popPage() {
    if (pagesStack.isNotEmpty) {
      int removedPage = pagesStack.removeLast();

      //Return Last Page if Stack is not Empty
      if (pagesStack.isNotEmpty) {
        currentIndex = pagesStack.last;
        emit(indexToState(currentIndex));
      } else {
        if (state is CustomNavigationBarAreYouSureYouWantToExit) {
          emit(CustomNavigationBarExit());
          return CustomNavigationBarExit();
        } else {
          pagesStack.add(removedPage);
          currentIndex = removedPage;
          emit(CustomNavigationBarAreYouSureYouWantToExit());
          return CustomNavigationBarAreYouSureYouWantToExit();
        }
      }
    }
    return state;
  }

  CustomNavigationBarState indexToState(int index) {
    switch (index) {
      case 0:
        return CustomNavigationBarHome();
      case 1:
        return CustomNavigationBarJournal();
      case 2:
        return CustomNavigationBarCommunity();
      case 3:
        return CustomNavigationBarProfile();
      default:
        return CustomNavigationBarHome();
    }
  }

  int stateToIndex(CustomNavigationBarState state) {
    switch (state.runtimeType) {
      case const (CustomNavigationBarHome):
        return 0;
      case const (CustomNavigationBarJournal):
        return 1;
      case const (CustomNavigationBarCommunity):
        return 2;
      case const (CustomNavigationBarProfile):
        return 3;
      default: //Return Home
        return 0;
    }
  }
}
