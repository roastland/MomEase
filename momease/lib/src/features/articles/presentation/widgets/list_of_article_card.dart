import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momease/src/features/articles/presentation/bloc/articles_bloc.dart';
import 'package:momease/src/features/articles/presentation/widgets/article_card.dart';

class ListOfArticleCard extends StatefulWidget {
  const ListOfArticleCard({super.key});

  @override
  State<ListOfArticleCard> createState() => _ListOfArticleCardState();
}

class _ListOfArticleCardState extends State<ListOfArticleCard> {
  int cardIdx = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<ArticlesBloc>(context),
      builder: (context, state) {
        if (state is ArticlesInitial) {
          BlocProvider.of<ArticlesBloc>(context).add(FetchArticleList());
          return Container();
        } else if (state is ArticlesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ArticlesLoaded) {
          return SizedBox(
            height: 250,
            child: PageView.builder(
              itemCount: state.articlesList.length,
              controller: PageController(viewportFraction: 0.8),
              onPageChanged: (index) => setState(() => cardIdx = index),
              itemBuilder: (context, index) {
                return AnimatedPadding(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.fastOutSlowIn,
                  padding: EdgeInsets.all(cardIdx == index ? 0.0 : 8.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ArticleDetailPage(
                      //       article: state.articlesList[index],
                      //     ),
                      //   ),
                      // );
                    },
                    child: ArticleCard(
                        articleList: state.articlesList, articleIdx: index),
                  ),
                );
              },
            ),
          );
        } else if (state is FailureState) {
          return Center(
            child: Text(state.message),
          );
        }
        return Container();
      },
    );
  }
}
