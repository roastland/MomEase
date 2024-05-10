// import 'package:flutter/material.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:momease/src/core/database/database.dart';
// import 'package:momease/src/features/community/data/datasources/community_post_local_data_source.dart';
// import 'package:momease/src/features/community/data/models/community_post_model.dart';
// import 'package:momease/src/features/community/domain/entities/community_entity.dart';
// import 'package:momease/src/features/community/domain/entities/community_post_entity.dart';
// import 'package:momease/src/features/community/presentation/bloc/community_details_post_bloc.dart';

// class CreatePostButton extends StatefulWidget {
//   const CreatePostButton(
//       {super.key, required this.communityItem, required this.lastPostId});

//   final CommunityEntity communityItem;
//   final int lastPostId;

//   @override
//   State<CreatePostButton> createState() => _CreatePostButtonState();
// }

// class _CreatePostButtonState extends State<CreatePostButton> {
//   late final CommunityEntity item;
//   late int lastPostId;
//   late String inputPost;
//   late final List<CommunityPostEntity> communityPostList;
//   late final CommunityPostLocalDataSource localDataSource;

//   @override
//   void initState() {
//     super.initState();
//     item = widget.communityItem;
//     lastPostId = widget.lastPostId;
//     inputPost = '';
//     communityPostList = [];
//     localDataSource = CommunityPostLocalDataSourceImpl(database: _database);
//     _database = AppDatabase as AppDatabase;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//         onPressed: () => showDialog(
//               context: context,
//               builder: (_) => AlertDialog(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0)),
//                 title: const Text('Create New Post'),
//                 titleTextStyle:
//                     const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 content: TextField(
//                   onChanged: (String value) {
//                     setState(() {
//                       inputPost = value;
//                     });
//                   },
//                 ),
//                 actions: [
//                   TextButton(
//                       onPressed: () {
//                         setState(() {
//                           communityPostList.add(CommunityPostEntity(
//                               id: lastPostId + 1,
//                               topicId: item.id,
//                               username: 'Georgia',
//                               text: inputPost,
//                               timestamp: DateTime.now(),
//                               countComments: 0,
//                               countViews: 0));
//                         });
//                         localDataSource.cacheCommunityPosts(
//                             communityPostList as List<CommunityPostModel>);
//                         // BlocProvider.of<CommunityDetailsPostBloc>(context).add(
//                         //     CreateCommunityDetailsPost(CommunityPostEntity(
//                         //         id: lastPostId + 1,
//                         //         topicId: item.id,
//                         //         username: 'Georgia',
//                         //         text: inputPost,
//                         //         timestamp: DateTime.now(),
//                         //         countComments: 0,
//                         //         countViews: 0)));

//                         Navigator.pop(context);
//                       },
//                       child: const Text('Add'))
//                 ],
//               ),
//             ),
//         child: const Text('Create Post'));
//   }
// }
