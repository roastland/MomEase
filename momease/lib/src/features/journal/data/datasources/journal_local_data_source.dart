import 'package:momease/src/core/database/database.dart';
import 'package:momease/src/features/journal/data/models/journal_model.dart';

abstract class JournalLocalDataSource {
  Future<List<JournalModel>> getJournalList();
  Future<void> cacheJournals(List<JournalModel> journalToCache);
}

class JournalLocalDataSourceImpl implements JournalLocalDataSource {
  late final AppDatabase _database;

  JournalLocalDataSourceImpl({required AppDatabase database}) {
    _database = database;
  }

  @override
  Future<List<JournalModel>> getJournalList() async {
    return await _database.readAllJournal();
  }

  @override
  Future<void> cacheJournals(List<JournalModel> journalToCache) async {
    for (JournalModel journal in journalToCache) {
      await _database.createJournal(journal);
    }
  }
}
