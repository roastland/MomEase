import 'package:momease/src/features/therapy/domain/entities/therapy_entity.dart';

class TherapyModel extends TherapyEntity {
  const TherapyModel({
    required super.id,
    required super.title,
    super.description,
    required super.imageUrl,
  });

  factory TherapyModel.fromJson(Map<String, dynamic> json) {
    return TherapyModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
