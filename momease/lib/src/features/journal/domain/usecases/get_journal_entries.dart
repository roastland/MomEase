import 'package:dartz/dartz.dart';
import 'package:momease/src/core/error/failures.dart';
import 'package:momease/src/core/usecases/usecase.dart';
import 'package:momease/src/features/journal/domain/entities/journal_entity.dart';
import 'package:momease/src/features/journal/domain/repositories/journal_repository.dart';

class GetJournalEntries implements UseCase<List<JournalEntity>, NoParams> {
  final JournalRepository repository;

  GetJournalEntries(this.repository);

  @override
  Future<Either<Failure, List<JournalEntity>>> call(NoParams params) async {
    return await repository.getJournalEntries();
  }
}
