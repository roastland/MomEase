import 'package:flutter/material.dart';

import 'package:momease/src/features/community/domain/entities/community_entity.dart';

class CommunityTopicCard extends StatefulWidget {
  const CommunityTopicCard({super.key, required this.communityItem});

  final CommunityEntity communityItem;

  @override
  State<CommunityTopicCard> createState() => _CommunityTopicCardState();
}

class _CommunityTopicCardState extends State<CommunityTopicCard> {
  late CommunityEntity item;

  @override
  void initState() {
    super.initState();
    item = widget.communityItem;
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
            height: 130,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                isThreeLine: true,
                title: Text(
                  item.topic,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 13),
                ),
                subtitle: Text(
                  item.description,
                  style: const TextStyle(fontSize: 10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.comment, size: 20),
                    Text(
                      '${item.countPost > 1000 ? item.countPost ~/ 1000 : item.countPost}${item.countPost > 1000 ? 'K' : ''}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
