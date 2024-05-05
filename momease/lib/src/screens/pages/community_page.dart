import 'package:flutter/material.dart';
import 'package:momease/src/features/community/presentation/widgets/community_search_bar.dart';
import 'package:momease/src/features/community/presentation/widgets/popular_topics_grid_view.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
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
          Padding(
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
          Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: CommunitySearchBar()),
          Padding(
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
            padding: EdgeInsets.all(8.0),
            child: PopularTopicsGridView(),
          )),
        ],
      ),
    );
  }
}
