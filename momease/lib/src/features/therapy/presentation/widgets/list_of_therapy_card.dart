import 'package:flutter/material.dart';
import 'package:momease/src/features/therapy/presentation/widgets/therapy_card.dart';

class ListOfTherapyCard extends StatefulWidget {
  const ListOfTherapyCard({super.key});

  @override
  State<ListOfTherapyCard> createState() => _ListOfTherapyCardState();
}

class _ListOfTherapyCardState extends State<ListOfTherapyCard> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: PageView.builder(
        itemCount: 3,
        controller: PageController(viewportFraction: 0.8),
        onPageChanged: (index) => setState(() => _index = index),
        itemBuilder: (context, index) {
          return AnimatedPadding(
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn,
            padding: EdgeInsets.all(_index == index ? 0.0 : 8.0),
            child: TherapyCard(therapyIdx: _index),
          );
        },
      ),
    );
  }
}
