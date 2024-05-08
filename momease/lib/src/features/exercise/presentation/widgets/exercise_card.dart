import 'package:flutter/material.dart';

import 'package:momease/src/features/exercise/domain/entities/exercise_entity.dart';

class ExerciseCard extends StatefulWidget {
  const ExerciseCard(
      {super.key, required this.exerciseList, required this.exerciseIdx});

  final List<ExerciseEntity> exerciseList;
  final int exerciseIdx;

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  late List<ExerciseEntity> exerciseList;
  late int exerciseIdx;

  @override
  void initState() {
    super.initState();
    exerciseList = widget.exerciseList;
    exerciseIdx = widget.exerciseIdx;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Center(
          child: Text(
              'Exercise $exerciseIdx, ${exerciseList[exerciseIdx].title}')),
    );
  }
}
