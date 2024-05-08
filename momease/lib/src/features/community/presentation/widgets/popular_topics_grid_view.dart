import 'package:flutter/material.dart';

import 'package:momease/src/features/community/presentation/widgets/community_topic_card.dart';

class PopularTopicsGridView extends StatefulWidget {
  const PopularTopicsGridView({super.key, required this.gridCount});
  final int gridCount;

  @override
  State<PopularTopicsGridView> createState() => _PopularTopicsGridViewState();
}

class _PopularTopicsGridViewState extends State<PopularTopicsGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: widget.gridCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
        children: List.generate(6, (int index) {
          return const CommunityTopicCard();
        }));
  }
}
