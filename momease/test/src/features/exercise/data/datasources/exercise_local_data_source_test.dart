import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:momease/src/core/database/database.dart';
import 'package:momease/src/features/exercise/data/datasources/exercise_local_data_source.dart';
import 'package:momease/src/features/exercise/data/models/exercise_model.dart';

@GenerateNiceMocks([MockSpec<AppDatabase>()])
import 'exercise_local_data_source_test.mocks.dart';

void main() {
  late ExerciseLocalDataSourceImpl dataSource;
  late MockAppDatabase mockDatabase;

  setUp(() {
    mockDatabase = MockAppDatabase();
    dataSource = ExerciseLocalDataSourceImpl(database: mockDatabase);
  });

  group('getExerciseList', () {
    test('should return a list of ExerciseModel from the database', () async {
      // arrange
      when(mockDatabase.readAllExercise()).thenAnswer((_) async => []);
      // act
      final result = await dataSource.getExerciseList();
      // assert
      verify(mockDatabase.readAllExercise());
      expect(result, equals([]));
    });

    test(
        'should return an empty list when there is no exercise data in the database',
        () async {
      // arrange
      when(mockDatabase.readAllExercise()).thenAnswer((_) async => []);
      // act
      final result = await dataSource.getExerciseList();
      // assert
      verify(mockDatabase.readAllExercise());
      expect(result, equals([]));
    });
  });

  group('cacheExercises', () {
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

    test('should insert a list of ExerciseModel to the database', () async {
      // arrange
      when(mockDatabase.updateTherapy(any))
          .thenAnswer((_) async => Future.value());
      // act
      await dataSource.cacheExercises(tExerciseList);
      // assert
      verify(mockDatabase.createExercise(tExercise1));
      verify(mockDatabase.createExercise(tExercise2));
    });
  });
}
