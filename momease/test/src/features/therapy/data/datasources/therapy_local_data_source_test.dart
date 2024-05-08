import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:momease/src/core/database/database.dart';
import 'package:momease/src/core/util/json_data_reader.dart';
import 'package:momease/src/features/therapy/data/datasources/therapy_local_data_source.dart';
import 'package:momease/src/features/therapy/data/models/therapy_model.dart';

@GenerateNiceMocks([MockSpec<AppDatabase>()])
import 'therapy_local_data_source_test.mocks.dart';

void main() {
  late TherapyLocalDataSourceImpl dataSource;
  late MockAppDatabase mockDatabase;

  setUp(() {
    mockDatabase = MockAppDatabase();
    dataSource = TherapyLocalDataSourceImpl(database: mockDatabase);
  });

  group('getTherapyList', () {
    test('should return a list of TherapyModel from the database', () async {
      WidgetsFlutterBinding.ensureInitialized();

      final Map<String, dynamic> jsonMap =
          await parseJsonFromAssets('./assets/json_data/therapy.json');
      final data = jsonMap['data'];
      final tTherapyList = [data[0], data[1]]
          .map((therapy) => TherapyModel.fromJson(therapy))
          .toList();

      // arrange
      when(mockDatabase.readTherapy()).thenAnswer((_) async => tTherapyList);
      // act
      final result = await dataSource.getTherapyList();
      // assert
      verify(mockDatabase.readTherapy());
      expect(result, equals(tTherapyList));
    });

    test(
        'should return an empty list when there is no therapy data in the database',
        () async {
      // arrange
      when(mockDatabase.readTherapy()).thenAnswer((_) async => []);
      // act
      final result = await dataSource.getTherapyList();
      // assert
      verify(mockDatabase.readTherapy());
      expect(result, equals([]));
    });
  });

  group('cacheTherapies', () {
    const tTherapy1 = TherapyModel(
      id: 1,
      title: 'Music Therapy',
      imageUrl: 'imageUrl',
      description: 'description',
    );
    const tTherapy2 = TherapyModel(
      id: 2,
      title: 'Art Therapy',
      imageUrl: 'imageUrl',
      description: 'description',
    );
    final tTherapyList = [tTherapy1, tTherapy2];

    test('should insert a TherapyModel into the database', () async {
      // arrange
      when(mockDatabase.updateTherapy(any))
          .thenAnswer((_) async => Future.value());
      // act
      await dataSource.cacheTherapies(tTherapyList);
      // assert
      verify(mockDatabase.createTherapy(tTherapy1));
      verify(mockDatabase.createTherapy(tTherapy2));
    });
  });
}
