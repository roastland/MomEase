import 'package:equatable/equatable.dart';

class CommunityEntity extends Equatable {
  const CommunityEntity({
    required this.id,
    required this.topic,
    required this.imageUrl,
    required this.description,
    required this.countPost,
  });

  final int id;
  final String topic;
  final String imageUrl;
  final String description;
  final int countPost;

  @override
  List<Object?> get props => [id, topic, imageUrl, description, countPost];
}
