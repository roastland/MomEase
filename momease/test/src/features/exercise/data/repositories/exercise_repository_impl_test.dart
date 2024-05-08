import 'package:flutter/material.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:momease/src/core/error/exception.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/features/exercise/data/datasources/exercise_local_data_source.dart';
import 'package:momease/src/features/exercise/data/models/exercise_model.dart';
import 'package:momease/src/features/exercise/data/repositories/exercise_repository_impl.dart';

@GenerateNiceMocks([MockSpec<ExerciseLocalDataSourceImpl>()])
import 'exercise_repository_impl_test.mocks.dart';

void main() {
  late ExerciseRepositoryImpl repository;
  late MockExerciseLocalDataSourceImpl mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockExerciseLocalDataSourceImpl();
    repository = ExerciseRepositoryImpl(
      localDataSource: mockLocalDataSource,
    );
  });

  const tExercise1 = ExerciseModel(
    id: 1,
    title: 'Yoga Exercise',
    imageUrl: 'imageUrl',
    description: 'description',
  );
  const tExercise2 = ExerciseModel(
    id: 2,
    title: 'Breathing Exercise',
    imageUrl: 'imageUrl',
    description: 'description',
  );
  final tExerciseList = [tExercise1, tExercise2];

  group('getExerciseList', () {
    WidgetsFlutterBinding.ensureInitialized();

    test('should call getExerciseList from the local data source', () async {
      // arrange
      when(mockLocalDataSource.getExerciseList())
          .thenAnswer((_) async => tExerciseList);
      // act
      final result = await repository.getExerciseList();
      // assert
      verify(mockLocalDataSource.getExerciseList());
      expect(result, equals(Right(tExerciseList)));
    });

    test('should return CacheFailure when there is no cached data present',
        () async {
      // arrange
      when(mockLocalDataSource.getExerciseList()).thenThrow(CacheException());
      // act
      final result = await repository.getExerciseList();
      // assert
      verify(mockLocalDataSource.getExerciseList());
      expect(result, equals(Left(CacheFailure())));
    });
  });
}
