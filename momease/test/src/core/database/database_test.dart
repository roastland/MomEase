import 'package:flutter_test/flutter_test.dart';
import 'package:momease/src/core/database/database.dart';
import 'package:momease/src/features/therapy/data/models/therapy_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  // Setup sqflite_common_ffi for flutter test
  setUpAll(() {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  });

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

  Future<void> insertAllTherapy() async {
    await AppDatabase.instance.createTherapy(tTherapy1);
    await AppDatabase.instance.createTherapy(tTherapy2);
  }

  group("therapy", () {
    test(
      'should return empty list when there is no therapy data in the database',
      () async {
        // arrange
        await AppDatabase.instance.deleteAllTable();
        // act
        final result = await AppDatabase.instance.readTherapy();
        // assert
        expect(result, []);
      },
    );

    test(
      'should return all therapy data from the database',
      () async {
        // arrange
        await AppDatabase.instance.deleteAllTable();
        // act
        await insertAllTherapy();
        final result = await AppDatabase.instance.readTherapy();
        // assert
        expect(result, [tTherapy1, tTherapy2]);
      },
    );
  });
}
