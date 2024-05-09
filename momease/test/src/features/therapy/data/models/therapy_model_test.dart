import 'package:flutter_test/flutter_test.dart';
import 'package:momease/src/features/therapy/data/models/therapy_model.dart';
import 'package:momease/src/features/therapy/domain/entities/therapy_entity.dart';

void main() {
  const tTherapyModel = TherapyModel(
    id: 1,
    title: 'Music Therapy',
    imageUrl: 'imageUrl',
    description: 'description',
  );

  test('should be a subclass of TherapyEntity', () {
    // assert
    expect(tTherapyModel, isA<TherapyEntity>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is valid', () {
      // arrange
      final Map<String, dynamic> jsonMap = {
        'id': 1,
        'title': 'Music Therapy',
        'imageUrl': 'imageUrl',
        'description': 'description',
      };
      // act
      final result = TherapyModel.fromJson(jsonMap);
      // assert
      expect(result, tTherapyModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      // act
      final result = tTherapyModel.toJson();
      // assert
      final expectedMap = {
        'id': 1,
        'title': 'Music Therapy',
        'imageUrl': 'imageUrl',
        'description': 'description',
      };
      expect(result, expectedMap);
    });
  });
}
