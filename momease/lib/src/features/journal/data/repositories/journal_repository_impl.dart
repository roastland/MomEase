import 'package:dartz/dartz.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/core/util/json_data_reader.dart';
import 'package:momease/src/features/journal/data/datasources/journal_local_data_source.dart';
import 'package:momease/src/features/journal/data/models/journal_model.dart';
import 'package:momease/src/features/journal/domain/entities/journal_entity.dart';
import 'package:momease/src/features/journal/domain/repositories/journal_repository.dart';

class JournalRepositoryImpl implements JournalRepository {
  final JournalLocalDataSource localDataSource;

  JournalRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<JournalEntity>>> getJournalEntries() async {
    final Map<String, dynamic> jsonMap =
        await parseJsonFromAssets('./assets/json_data/journal.json');
    final data = jsonMap['data'];
    final journalList = List.generate(data.length, (int index) => data[index])
        .map((community) => JournalModel.fromJson(community))
        .toList();
    localDataSource.cacheJournals(journalList);

    try {
      final localJournal = await localDataSource.getJournalList();
      return Right(localJournal);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createJournalEntry(String journalEntry) {
    // TODO: implement createJournalEntry
    throw UnimplementedError();
  }

  @override
  Future<void> deleteJournalEntry(String journalEntryId) {
    // TODO: implement deleteJournalEntry
    throw UnimplementedError();
  }

  @override
  Future<void> updateJournalEntry(String journalEntryId, String journalEntry) {
    // TODO: implement updateJournalEntry
    throw UnimplementedError();
  }
}
