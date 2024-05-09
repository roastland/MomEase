import 'package:momease/src/features/community/domain/entities/community_entity.dart';

class CommunityModel extends CommunityEntity {
  const CommunityModel({
    required super.id,
    required super.topic,
    required super.imageUrl,
    required super.description,
    required super.countPost,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      id: json['id'],
      topic: json['topic'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      countPost: json['countPost'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'topic': topic,
      'imageUrl': imageUrl,
      'description': description,
      'countPost': countPost,
    };
  }
}
