import 'package:momease/src/features/articles/domain/entities/article_entity.dart';

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    required super.id,
    required super.title,
    required super.imageUrl,
    super.description,
    required super.readingTime,
    required super.author,
    required super.publishedOn,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      readingTime: json['readingTime'],
      author: json['author'],
      publishedOn: DateTime.parse(json['publishedOn']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'description': description,
      'readingTime': readingTime,
      'author': author,
      'publishedOn': publishedOn.toString(),
    };
  }
}
