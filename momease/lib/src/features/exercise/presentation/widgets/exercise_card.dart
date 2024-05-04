import 'package:flutter/material.dart';

class ExerciseCard extends StatefulWidget {
  const ExerciseCard({super.key, required this.exerciseIdx});
  final int exerciseIdx;

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 4,
      child: Center(child: Text('Exercise ')),
    );
  }
}
