import 'package:flutter/material.dart';

class CommunityPostSearchBar extends StatefulWidget {
  const CommunityPostSearchBar({super.key});

  @override
  State<CommunityPostSearchBar> createState() => _CommunityPostSearchBarState();
}

class _CommunityPostSearchBarState extends State<CommunityPostSearchBar> {
  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
        isFullScreen: false,
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: controller,
            padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0)),
            onTap: () {
              controller.openView();
            },
            onChanged: (_) {
              controller.openView();
            },
            leading: const Icon(Icons.search),
            hintText: "Search Post",
          );
        },
        // TODO: change this with search history
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return List<ListTile>.generate(5, (int index) {
            final String item = 'item $index';
            return ListTile(
              title: Text(item),
              onTap: () {
                setState(() {
                  controller.closeView(item);
                });
              },
            );
          });
        });
  }
}
