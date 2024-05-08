import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  const ArticleEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.description,
    required this.readingTime,
    required this.author,
    required this.publishedOn,
  });

  final int id;
  final String title;
  final String imageUrl;
  final String? description;
  final int readingTime;
  final String author;
  final DateTime publishedOn;

  @override
  List<Object?> get props =>
      [id, title, imageUrl, description, readingTime, author, publishedOn];
}
