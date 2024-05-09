import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momease/src/features/community/presentation/bloc/community_bloc.dart';
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
    return BlocBuilder(
      bloc: BlocProvider.of<CommunityBloc>(context),
      builder: (context, state) {
        if (state is CommunityInitial) {
          BlocProvider.of<CommunityBloc>(context).add(FetchCommunityList());
          return const Center(child: CircularProgressIndicator());
        } else if (state is CommunityLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CommunityLoaded) {
          return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: widget.gridCount,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.7,
              children: state.communityList.map((item) {
                return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => CommunityDetailPage(
                      //       communityItem: item,
                      //     ),
                      //   ),
                      // );
                    },
                    child: CommunityTopicCard(communityItem: item));
              }).toList());
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
