import 'package:momease/src/core/database/database.dart';
import 'package:momease/src/features/therapy/data/models/therapy_model.dart';

abstract class TherapyLocalDataSource {
  Future<List<TherapyModel>> getTherapyList();
  Future<void> cacheTherapies(List<TherapyModel> therapyToCache);
}

class TherapyLocalDataSourceImpl implements TherapyLocalDataSource {
  late final AppDatabase _database;

  TherapyLocalDataSourceImpl({required AppDatabase database}) {
    _database = database;
  }

  @override
  Future<List<TherapyModel>> getTherapyList() async {
    return await _database.readTherapy();
  }

  @override
  Future<void> cacheTherapies(List<TherapyModel> therapyToCache) async {
    for (TherapyModel therapy in therapyToCache) {
      await _database.createTherapy(therapy);
    }
  }
}
