import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momease/injection_container.dart';
import 'package:momease/src/features/community/data/models/community_post_model.dart';
import 'package:momease/src/features/community/domain/entities/community_entity.dart';
import 'package:momease/src/features/community/domain/entities/community_post_entity.dart';
// import 'package:momease/src/features/community/domain/entities/community_post_entity.dart';
import 'package:momease/src/features/community/presentation/bloc/community_details_post_bloc.dart';
import 'package:momease/src/features/community/presentation/widgets/community_post_search_bar.dart';
import 'package:momease/src/features/community/presentation/widgets/create_post_button.dart';

class CommunityDetailPage extends StatefulWidget {
  const CommunityDetailPage({super.key, required this.communityItem});

  final CommunityEntity communityItem;

  @override
  State<CommunityDetailPage> createState() => _CommunityDetailPageState();
}

class _CommunityDetailPageState extends State<CommunityDetailPage> {
  late final CommunityEntity topicItem;
  late final List<CommunityPostEntity> postList;
  late bool isListFilled;

  @override
  void initState() {
    super.initState();
    topicItem = widget.communityItem;
    postList = [];
    isListFilled = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CommunityDetailsPostBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(topicItem.topic),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: AspectRatio(
                      aspectRatio: 3 / 2,
                      child:
                          Image.asset(topicItem.imageUrl, fit: BoxFit.cover))),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  topicItem.description,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.comment, size: 20),
                    Text(
                      '${topicItem.countPost > 1000 ? topicItem.countPost ~/ 1000 : topicItem.countPost}${topicItem.countPost > 1000 ? 'K' : ''}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 11),
                    ),
                  ],
                ),
              ),
              BlocBuilder<CommunityDetailsPostBloc, CommunityDetailsPostState>(
                builder: (context, state) {
                  if (state is CommunityDetailsPostInitial) {
                    BlocProvider.of<CommunityDetailsPostBloc>(context)
                        .add(FetchCommunityDetailsPost(topicItem.id));
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CommunityDetailsPostLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CommunityDetailsPostLoaded) {
                    String inputPost = '';
                    if (!isListFilled) {
                      for (int i = 0; i < state.communityPostList.length; i++) {
                        postList.add(state.communityPostList[i]);
                      }
                      isListFilled = true;
                    }
                    return Column(
                      children: [
                        // CreatePostButton(
                        //   communityItem: topicItem,
                        //   lastPostId: state.communityPostList.isNotEmpty
                        //       ? state.communityPostList.last.id
                        //       : -1,
                        // ),
                        ElevatedButton(
                            onPressed: () => showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    title: const Text('Create New Post'),
                                    titleTextStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    content: TextField(
                                      onChanged: (String value) {
                                        setState(() {
                                          inputPost = value;
                                        });
                                      },
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              postList.add(CommunityPostModel(
                                                  id: (postList.isNotEmpty
                                                          ? postList.last.id
                                                          : -1) +
                                                      1,
                                                  topicId: topicItem.id,
                                                  username: 'Georgia',
                                                  text: inputPost,
                                                  timestamp: DateTime.now(),
                                                  countComments: 0,
                                                  countViews: 0));
                                            });

                                            Navigator.pop(context);
                                          },
                                          child: const Text('Add'))
                                    ],
                                  ),
                                ),
                            child: const Text('Create Post')),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('All Post'),
                              ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.arrow_drop_down),
                                  label: const Text('Sort By')),
                            ]),
                        const CommunityPostSearchBar(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2.5,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: postList.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  clipBehavior: Clip.antiAlias,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        isThreeLine: true,
                                        title: Text(
                                          postList[index].username,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13),
                                        ),
                                        subtitle: Text(
                                          postList[index].text,
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 0, 0, 8),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Icon(Icons.comment, size: 20),
                                            Text(
                                              postList[index]
                                                  .countComments
                                                  .toString(),
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        )
                      ],
                    );
                  } else if (state is FailureState) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
