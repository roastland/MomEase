import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momease/src/core/navigation_bar/cubit/custom_navigation_bar_cubit.dart';

void main() {
  late CustomNavigationBarCubit tCubit;

  setUp(() {
    tCubit = CustomNavigationBarCubit();
  });

  test('initialState should be HomePage', () {
    expect(tCubit.state, equals(CustomNavigationBarHome()));
  });

  group('State to Index', () {
    test('Should return 0 if CustomNavigationBarHome State was called', () {
      expect(tCubit.stateToIndex(CustomNavigationBarHome()), equals(0));
    });
    test('Should return 1 if CustomNavigationBarJournal State was called', () {
      expect(tCubit.stateToIndex(CustomNavigationBarJournal()), equals(1));
    });
    test('Should return 2 if CustomNavigationBarCommunity State was called',
        () {
      expect(tCubit.stateToIndex(CustomNavigationBarCommunity()), equals(2));
    });
    test('Should return 3 if CustomNavigationBarProfile State was called', () {
      expect(tCubit.stateToIndex(CustomNavigationBarProfile()), equals(3));
    });
  });

  group('Index to State', () {
    test('Should return CustomNavigationBarHome if index 0 was called', () {
      expect(tCubit.indexToState(0), equals(CustomNavigationBarHome()));
    });
    test('Should return CustomNavigationBarJournal if index 1 was called', () {
      expect(tCubit.indexToState(1), equals(CustomNavigationBarJournal()));
    });
    test('Should return CustomNavigationBarCommunity if index 2 was called',
        () {
      expect(tCubit.indexToState(2), equals(CustomNavigationBarCommunity()));
    });
    test('Should return CustomNavigationBarProfile if index 3 was called', () {
      expect(tCubit.indexToState(3), equals(CustomNavigationBarProfile()));
    });
    test('Should return CustomNavigationBarHome if other index was called', () {
      expect(tCubit.indexToState(-1), equals(CustomNavigationBarHome()));
      expect(tCubit.indexToState(100), equals(CustomNavigationBarHome()));
    });
  });

  group('Push Page', () {
    blocTest<CustomNavigationBarCubit, CustomNavigationBarState>(
      'should not emits any state when Same Page is called.',
      build: () => CustomNavigationBarCubit(),
      act: (cubit) => cubit.pushPage(0),
      expect: () => const <CustomNavigationBarState>[],
    );

    test(
      'should not change page stack if Same Page is called.',
      () async {
        // arrange
        final stack = tCubit.pagesStack;

        // act
        tCubit.pushPage(tCubit.stateToIndex(CustomNavigationBarHome()));

        // assert
        expect(tCubit.pagesStack, equals(stack));
      },
    );

    blocTest<CustomNavigationBarCubit, CustomNavigationBarState>(
      'should emits Correct State when Different Page is called.',
      build: () => CustomNavigationBarCubit(),
      act: (cubit) =>
          cubit.pushPage(cubit.stateToIndex(CustomNavigationBarJournal())),
      expect: () => <CustomNavigationBarState>[CustomNavigationBarJournal()],
    );

    test(
      'should add new page index to stack if Different Page is called.',
      () async {
        // arrange
        final stack = tCubit.pagesStack;

        // act
        tCubit.pushPage(tCubit.stateToIndex(CustomNavigationBarJournal()));
        stack.add(tCubit.stateToIndex(CustomNavigationBarJournal()));

        // assert
        expect(tCubit.pagesStack, equals(stack));
      },
    );
  });

  group('Pop Page', () {
    blocTest<CustomNavigationBarCubit, CustomNavigationBarState>(
      'should not emits any state when Stack is Empty before pop.',
      build: () => CustomNavigationBarCubit(),
      act: (cubit) {
        cubit.pagesStack.clear();
        cubit.popPage();
      },
      expect: () => const <CustomNavigationBarState>[],
    );

    blocTest<CustomNavigationBarCubit, CustomNavigationBarState>(
      'should emits Are You Sure You Want To Exit State when Stack is Empty after pop 1x.',
      build: () => CustomNavigationBarCubit(),
      act: (cubit) {
        cubit.popPage();
      },
      expect: () => <CustomNavigationBarState>[
        CustomNavigationBarAreYouSureYouWantToExit()
      ],
    );

    blocTest<CustomNavigationBarCubit, CustomNavigationBarState>(
      'should emits Exit State when Stack is Empty after pop 2x.',
      build: () => CustomNavigationBarCubit(),
      act: (cubit) {
        cubit.popPage();
        cubit.popPage();
      },
      expect: () => <CustomNavigationBarState>[
        CustomNavigationBarAreYouSureYouWantToExit(),
        CustomNavigationBarExit(),
      ],
    );

    blocTest<CustomNavigationBarCubit, CustomNavigationBarState>(
      'should emits Last State when Stack is not Empty after pop.',
      build: () => CustomNavigationBarCubit(),
      act: (cubit) {
        cubit.pagesStack.add(cubit.stateToIndex(CustomNavigationBarJournal()));
        cubit.popPage();
      },
      expect: () => <CustomNavigationBarState>[CustomNavigationBarHome()],
    );
  });
}
