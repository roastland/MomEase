import 'package:flutter_test/flutter_test.dart';
import 'package:momease/src/features/exercise/data/models/exercise_model.dart';
import 'package:momease/src/features/exercise/domain/entities/exercise_entity.dart';

void main() {
  const tExerciseModel = ExerciseModel(
      id: 1,
      title: 'Yoga Exercise',
      imageUrl: 'imageUrl',
      description: 'description');

  test('should be a subclass of ExerciseEntity', () {
    // assert
    expect(tExerciseModel, isA<ExerciseEntity>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is valid', () {
      // arrange
      final Map<String, dynamic> jsonMap = {
        'id': 1,
        'title': 'Yoga Exercise',
        'imageUrl': 'imageUrl',
        'description': 'description',
      };
      // act
      final result = ExerciseModel.fromJson(jsonMap);
      // assert
      expect(result, tExerciseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      // act
      final result = tExerciseModel.toJson();
      // assert
      final expectedMap = {
        'id': 1,
        'title': 'Yoga Exercise',
        'imageUrl': 'imageUrl',
        'description': 'description',
      };
      expect(result, expectedMap);
    });
  });
}
