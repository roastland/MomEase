import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:momease/src/core/error/exception.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/features/therapy/data/datasources/therapy_local_data_source.dart';
import 'package:momease/src/features/therapy/data/models/therapy_model.dart';
import 'package:momease/src/features/therapy/data/repositories/therapy_repository_impl.dart';

@GenerateNiceMocks([MockSpec<TherapyLocalDataSourceImpl>()])
import 'therapy_repository_impl_test.mocks.dart';

void main() {
  late TherapyRepositoryImpl repository;
  late MockTherapyLocalDataSourceImpl mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockTherapyLocalDataSourceImpl();
    repository = TherapyRepositoryImpl(
      localDataSource: mockLocalDataSource,
    );
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
  final tTherapyList = [tTherapy1, tTherapy2];

  group('getTherapyList', () {
    test('should call getTherapyList from the local data source', () async {
      // arrange
      when(mockLocalDataSource.getTherapyList())
          .thenAnswer((_) async => tTherapyList);
      // act
      final result = await repository.getTherapyList();
      // assert
      verify(mockLocalDataSource.getTherapyList());
      expect(result, equals(Right(tTherapyList)));
    });

    test('should return CacheFailure when there is no cached data present',
        () async {
      // arrange
      when(mockLocalDataSource.getTherapyList()).thenThrow(CacheException());
      // act
      final result = await repository.getTherapyList();
      // assert
      verify(mockLocalDataSource.getTherapyList());
      expect(result, equals(Left(CacheFailure())));
    });
  });
}
