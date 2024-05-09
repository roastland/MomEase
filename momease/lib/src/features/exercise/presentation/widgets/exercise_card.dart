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
  late ExerciseEntity item;

  @override
  void initState() {
    super.initState();
    exerciseList = widget.exerciseList;
    exerciseIdx = widget.exerciseIdx;
    item = exerciseList[exerciseIdx];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            item.imageUrl,
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Text(
                item.title,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
