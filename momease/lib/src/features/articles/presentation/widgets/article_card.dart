import 'package:flutter/material.dart';

class ArticleCard extends StatefulWidget {
  const ArticleCard({super.key, required this.articleIdx});
  final int articleIdx;

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 4,
      child: Center(child: Text('Article ')),
    );
  }
}
