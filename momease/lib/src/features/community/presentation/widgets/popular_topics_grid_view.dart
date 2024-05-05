import 'package:flutter/material.dart';
import 'package:momease/src/features/community/presentation/widgets/community_topic_card.dart';

class PopularTopicsGridView extends StatelessWidget {
  const PopularTopicsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
        children: List.generate(6, (int index) {
          return const CommunityTopicCard();
        }));
  }
}
