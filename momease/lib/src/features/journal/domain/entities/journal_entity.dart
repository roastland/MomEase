import 'package:equatable/equatable.dart';

class JournalEntity extends Equatable {
  const JournalEntity({
    required this.date,
    required this.title,
    required this.mood,
    required this.journalText,
  });

  final DateTime date;
  final String title;
  final MoodType mood;
  final String journalText;

  @override
  List<Object?> get props => [date, title, mood, journalText];
}

// ignore: constant_identifier_names
enum MoodType { Amazing, Good, Normal, Bad, Terrible }
