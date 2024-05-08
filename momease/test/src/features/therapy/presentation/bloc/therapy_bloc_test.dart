import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:momease/src/core/error/error_messages.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/core/usecases/usecase.dart';
import 'package:momease/src/features/therapy/domain/entities/therapy_entity.dart';
import 'package:momease/src/features/therapy/domain/usecases/get_therapy_list.dart';
import 'package:momease/src/features/therapy/presentation/bloc/therapy_bloc.dart';

@GenerateNiceMocks([MockSpec<GetTherapyList>()])
import 'therapy_bloc_test.mocks.dart';

void main() {
  late TherapyBloc bloc;
  late MockGetTherapyList mockGetTherapyList;

  setUp(() {
    mockGetTherapyList = MockGetTherapyList();
    bloc = TherapyBloc(getTherapyList: mockGetTherapyList);
  });

  test('initialState should be TherapyInitial', () {
    // assert
    expect(bloc.state, equals(TherapyInitial()));
  });

  group('FetchTherapyList', () {
    const tTherapy1 = TherapyEntity(
      id: 1,
      title: 'Music Therapy',
      imageUrl: 'imageUrl',
      description: 'description',
    );
    const tTherapy2 = TherapyEntity(
      id: 2,
      title: 'Art Therapy',
      imageUrl: 'imageUrl',
      description: 'description',
    );
    final tTherapyList = [tTherapy1, tTherapy2];

    test('should get therapy list from the usecase', () async {
      // arrange
      when(mockGetTherapyList(any))
          .thenAnswer((_) async => Right(tTherapyList));
      // act
      bloc.add(FetchTherapyList());
      await untilCalled(mockGetTherapyList(any));
      // assert
      verify(mockGetTherapyList(NoParams()));
    });

    test(
        'should emit [TherapyLoading, TherapyLoaded] when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTherapyList(any))
          .thenAnswer((_) async => Right(tTherapyList));
      // assert later
      final expected = [
        TherapyLoading(),
        TherapyLoaded(tTherapyList),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(FetchTherapyList());
    });

    test('should emit [TherapyLoading, FailureState] when getting data fails',
        () async {
      // arrange
      when(mockGetTherapyList(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      // assert later
      final expected = [
        TherapyLoading(),
        const FailureState(CACHE_FAILURE_CODE, CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(FetchTherapyList());
    });

    test('should emit [TherapyLoading, FailureState] with proper error message',
        () async {
      // arrange
      when(mockGetTherapyList(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      // assert later
      final expected = [
        TherapyLoading(),
        const FailureState(CACHE_FAILURE_CODE, CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(FetchTherapyList());
    });
  });
}
