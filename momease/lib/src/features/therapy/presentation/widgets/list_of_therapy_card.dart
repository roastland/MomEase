import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momease/src/features/therapy/presentation/bloc/therapy_bloc.dart';
import 'package:momease/src/features/therapy/presentation/widgets/therapy_card.dart';

class ListOfTherapyCard extends StatefulWidget {
  const ListOfTherapyCard({super.key});

  @override
  State<ListOfTherapyCard> createState() => _ListOfTherapyCardState();
}

class _ListOfTherapyCardState extends State<ListOfTherapyCard> {
  int cardIdx = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<TherapyBloc>(context),
      builder: (context, state) {
        if (state is TherapyInitial) {
          BlocProvider.of<TherapyBloc>(context).add(FetchTherapyList());
          return Container();
        } else if (state is TherapyLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TherapyLoaded) {
          return SizedBox(
            height: 180,
            child: PageView.builder(
              itemCount: state.therapyList.length,
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
                      //     builder: (context) => TherapyDetailPage(
                      //       therapy: state.therapyList[index],
                      //     ),
                      //   ),
                      // );
                    },
                    child: TherapyCard(
                        therapyList: state.therapyList, therapyIdx: index),
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
