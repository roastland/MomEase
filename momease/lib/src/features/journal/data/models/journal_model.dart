import 'package:momease/src/features/journal/domain/entities/journal_entity.dart';

class JournalModel extends JournalEntity {
  const JournalModel({
    required super.date,
    required super.title,
    required super.mood,
    required super.journalText,
  });

  factory JournalModel.fromJson(Map<String, dynamic> json) {
    return JournalModel(
      date: DateTime.parse(json['date']),
      title: json['title'],
      mood: MoodType.values.byName(json['mood']),
      journalText: json['journalText'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toString(),
      'title': title,
      'mood': mood.name,
      'journalText': journalText,
    };
  }
}
