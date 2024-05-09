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
  late TherapyEntity item;

  @override
  void initState() {
    super.initState();
    therapyList = widget.therapyList;
    therapyIdx = widget.therapyIdx;
    item = therapyList[therapyIdx];
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
