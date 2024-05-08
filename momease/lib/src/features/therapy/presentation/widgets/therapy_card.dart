import 'package:flutter/material.dart';

import 'package:momease/src/features/therapy/domain/entities/therapy_entity.dart';

class TherapyCard extends StatefulWidget {
  const TherapyCard(
      {super.key, required this.therapyList, required this.therapyIdx});

  final List<TherapyEntity> therapyList;
  final int therapyIdx;

  @override
  State<TherapyCard> createState() => _TherapyCardState();
}

class _TherapyCardState extends State<TherapyCard> {
  late List<TherapyEntity> therapyList;
  late int therapyIdx;

  @override
  void initState() {
    super.initState();
    therapyList = widget.therapyList;
    therapyIdx = widget.therapyIdx;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Center(
          child: Text('Therapy $therapyIdx, ${therapyList[therapyIdx].title}')),
    );
  }
}
