import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:momease/src/features/articles/domain/entities/article_entity.dart';

class ArticleCard extends StatefulWidget {
  const ArticleCard(
      {super.key, required this.articleList, required this.articleIdx});

  final List<ArticleEntity> articleList;
  final int articleIdx;

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  late List<ArticleEntity> articleList;
  late int articleIdx;
  late ArticleEntity item;

  @override
  void initState() {
    super.initState();
    articleList = widget.articleList;
    articleIdx = widget.articleIdx;
    item = articleList[articleIdx];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            item.imageUrl,
            height: 125,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: Text(
                  '${item.readingTime} min read \u22c5 by ${item.author}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: ListTile(
                  title: Text(
                    item.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMMd().format(item.publishedOn),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
