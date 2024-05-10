import 'package:dartz/dartz.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/features/journal/domain/entities/journal_entity.dart';

abstract class JournalRepository {
  Future<void> createJournalEntry(String journalEntry);
  Future<void> deleteJournalEntry(String journalEntryId);
  Future<void> updateJournalEntry(String journalEntryId, String journalEntry);
  Future<Either<Failure, List<JournalEntity>>> getJournalEntries();
}
