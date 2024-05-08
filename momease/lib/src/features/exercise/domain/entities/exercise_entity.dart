import 'package:equatable/equatable.dart';

class ExerciseEntity extends Equatable {
  const ExerciseEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.description,
  });

  final int id;
  final String title;
  final String imageUrl;
  final String? description;

  @override
  List<Object?> get props => [id, title, imageUrl, description];
}
