import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:momease/src/core/error/error_messages.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/core/usecases/usecase.dart';
import 'package:momease/src/features/exercise/domain/entities/exercise_entity.dart';
import 'package:momease/src/features/exercise/domain/usecases/get_exercise_list.dart';
import 'package:momease/src/features/exercise/presentation/bloc/exercise_bloc.dart';

@GenerateNiceMocks([MockSpec<GetExerciseList>()])
import 'exercise_bloc_test.mocks.dart';

void main() {
  late ExerciseBloc bloc;
  late MockGetExerciseList mockGetExerciseList;

  setUp(() {
    mockGetExerciseList = MockGetExerciseList();
    bloc = ExerciseBloc(getExerciseList: mockGetExerciseList);
  });

  test('initial state should be ExerciseInitial', () {
    // assert
    expect(bloc.state, equals(ExerciseInitial()));
  });

  group('FetchExerciseList', () {
    const tExercise1 = ExerciseEntity(
      id: 1,
      title: 'Yoga Exercise',
      imageUrl: 'imageUrl',
      description: 'description',
    );
    const tExercise2 = ExerciseEntity(
      id: 2,
      title: 'Breathing Exercise',
      imageUrl: 'imageUrl',
      description: 'description',
    );
    final tExerciseList = [tExercise1, tExercise2];

    test('should get exercise list from the usecase', () async {
      // arrange
      when(mockGetExerciseList(any))
          .thenAnswer((_) async => Right(tExerciseList));
      // act
      bloc.add(FetchExerciseList());
      await untilCalled(mockGetExerciseList(any));
      // assert
      verify(mockGetExerciseList(NoParams()));
    });

    test(
        'should emit [ExerciseLoading, ExerciseLoaded] when data is gotten successfully',
        () async {
      // arrange
      when(mockGetExerciseList(any))
          .thenAnswer((_) async => Right(tExerciseList));
      // assert later
      final expected = [
        ExerciseLoading(),
        ExerciseLoaded(tExerciseList),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(FetchExerciseList());
    });

    test('should emit [ExerciseLoading, FailureState] when getting data fails',
        () async {
      // arrange
      when(mockGetExerciseList(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      // assert later
      final expected = [
        ExerciseLoading(),
        const FailureState(CACHE_FAILURE_CODE, CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(FetchExerciseList());
    });

    test('should emit [ExerciseLoading, FailureState] with error message',
        () async {
      // arrange
      when(mockGetExerciseList(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      // assert later
      final expected = [
        ExerciseLoading(),
        const FailureState(CACHE_FAILURE_CODE, CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(FetchExerciseList());
    });
  });
}
