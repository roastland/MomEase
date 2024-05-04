import 'package:flutter/material.dart';

class TherapyCard extends StatefulWidget {
  const TherapyCard({super.key, required this.therapyIdx});
  final int therapyIdx;

  @override
  State<TherapyCard> createState() => _TherapyCardState();
}

class _TherapyCardState extends State<TherapyCard> {
  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 4,
      child: Center(child: Text('Therapy ')),
    );
  }
}
