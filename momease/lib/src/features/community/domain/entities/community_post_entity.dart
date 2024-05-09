import 'package:equatable/equatable.dart';

class CommunityPostEntity extends Equatable {
  const CommunityPostEntity(
      {required this.id,
      required this.topicId,
      required this.username,
      required this.text,
      required this.timestamp,
      required this.countComments,
      required this.countViews});

  final int id;
  final int topicId;
  final String username;
  final String text;
  final DateTime timestamp;
  final int countComments;
  final int countViews;

  @override
  List<Object?> get props =>
      [id, topicId, username, text, timestamp, countComments, countViews];
}
