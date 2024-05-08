import 'package:dartz/dartz.dart';
import 'package:momease/src/core/error/exception.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/core/util/json_data_reader.dart';
import 'package:momease/src/features/therapy/data/datasources/therapy_local_data_source.dart';
import 'package:momease/src/features/therapy/data/models/therapy_model.dart';
import 'package:momease/src/features/therapy/domain/entities/therapy_entity.dart';
import 'package:momease/src/features/therapy/domain/repositories/therapy_repository.dart';

class TherapyRepositoryImpl implements TherapyRepository {
  final TherapyLocalDataSource localDataSource;

  TherapyRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<TherapyEntity>>> getTherapyList() async {
    final Map<String, dynamic> jsonMap =
        await parseJsonFromAssets('./assets/json_data/therapy.json');
    final data = jsonMap['data'];
    final therapyList = List.generate(data.length, (int index) => data[index])
        .map((therapy) => TherapyModel.fromJson(therapy))
        .toList();
    localDataSource.cacheTherapies(therapyList);

    try {
      final localTherapy = await localDataSource.getTherapyList();
      return Right(localTherapy);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
