import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    articleList = widget.articleList;
    articleIdx = widget.articleIdx;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Center(
          child: Text('Article $articleIdx, ${articleList[articleIdx].title}')),
    );
  }
}
