import 'package:flutter/material.dart';

import 'package:momease/src/features/community/presentation/widgets/community_search_bar.dart';
import 'package:momease/src/features/community/presentation/widgets/popular_topics_grid_view.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "You are not alone!",
                  // selectionColor: primaryTextColor,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      // color: primaryTextColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Sharing struggles and finding support",
                  // selectionColor: primaryTextColor,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      // color: primaryTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: SizedBox(height: 45, child: CommunitySearchBar())),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Popular Topics",
                  // selectionColor: primaryTextColor,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      // color: primaryTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  if (constraints.maxWidth <= 600) {
                    return const PopularTopicsGridView(gridCount: 2);
                  } else if (constraints.maxWidth <= 1200) {
                    return const PopularTopicsGridView(gridCount: 4);
                  } else {
                    return const PopularTopicsGridView(gridCount: 6);
                  }
                },
              ),
            )),
          ],
        ),
      ),
    );
  }
}
