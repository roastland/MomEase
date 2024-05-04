import 'package:flutter/cupertino.dart';
import 'package:momease/src/features/articles/presentation/widgets/article_card.dart';

class ListOfArticleCard extends StatefulWidget {
  const ListOfArticleCard({super.key});

  @override
  State<ListOfArticleCard> createState() => _ListOfArticleCardState();
}

class _ListOfArticleCardState extends State<ListOfArticleCard> {
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
            child: ArticleCard(articleIdx: _index),
          );
        },
      ),
    );
  }
}
