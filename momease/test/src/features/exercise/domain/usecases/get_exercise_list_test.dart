import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:momease/src/core/usecases/usecase.dart';
import 'package:momease/src/features/exercise/domain/entities/exercise_entity.dart';
import 'package:momease/src/features/exercise/domain/repositories/exercise_repository.dart';
import 'package:momease/src/features/exercise/domain/usecases/get_exercise_list.dart';

@GenerateNiceMocks([MockSpec<ExerciseRepository>()])
import 'get_exercise_list_test.mocks.dart';

void main() {
  late GetExerciseList usecase;
  late MockExerciseRepository mockExerciseRepository;

  setUp(() {
    mockExerciseRepository = MockExerciseRepository();
    usecase = GetExerciseList(mockExerciseRepository);
  });

  const tExerciseEntity1 = ExerciseEntity(
    id: 1,
    title: 'Yoga Exercise',
    imageUrl: 'imageUrl',
    description: 'description',
  );
  const tExerciseEntity2 = ExerciseEntity(
    id: 2,
    title: 'Breathing Exercise',
    imageUrl: 'imageUrl',
    description: 'description',
  );
  const tExerciseEntity3 = ExerciseEntity(
    id: 3,
    title: 'Walking Exercise',
    imageUrl: 'imageUrl',
    description: 'description',
  );
  final tExerciseList = [tExerciseEntity1, tExerciseEntity2, tExerciseEntity3];

  test('should get exercise list from the repository', () async {
    // arrange
    when(mockExerciseRepository.getExerciseList())
        .thenAnswer((_) async => Right(tExerciseList));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, Right(tExerciseList));
    verify(mockExerciseRepository.getExerciseList());
    verifyNoMoreInteractions(mockExerciseRepository);
  });
}
