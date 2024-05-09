import 'package:momease/src/features/community/domain/entities/community_post_entity.dart';

class CommunityPostModel extends CommunityPostEntity {
  const CommunityPostModel({
    required super.id,
    required super.topicId,
    required super.username,
    required super.text,
    required super.timestamp,
    required super.countComments,
    required super.countViews,
  });

  factory CommunityPostModel.fromJson(Map<String, dynamic> json) {
    return CommunityPostModel(
      id: json['id'],
      topicId: json['topicId'],
      username: json['username'],
      text: json['text'],
      timestamp: DateTime.parse(json['timestamp']),
      countComments: json['countComments'],
      countViews: json['countViews'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'topicId': topicId,
      'username': username,
      'text': text,
      'timestamp': timestamp.toString(),
      'countComments': countComments,
      'countViews': countViews,
    };
  }
}
