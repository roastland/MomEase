import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momease/src/features/exercise/presentation/bloc/exercise_bloc.dart';
import 'package:momease/src/features/exercise/presentation/widgets/exercise_card.dart';

class ListOfExerciseCard extends StatefulWidget {
  const ListOfExerciseCard({super.key});

  @override
  State<ListOfExerciseCard> createState() => _ListOfExerciseCardState();
}

class _ListOfExerciseCardState extends State<ListOfExerciseCard> {
  int cardIdx = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<ExerciseBloc>(context),
      builder: (context, state) {
        if (state is ExerciseInitial) {
          BlocProvider.of<ExerciseBloc>(context).add(FetchExerciseList());
          return Container();
        } else if (state is ExerciseLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ExerciseLoaded) {
          return SizedBox(
            height: 180,
            child: PageView.builder(
              itemCount: state.exerciseList.length,
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
                      //     builder: (context) => ExerciseDetailPage(
                      //       exercise: state.exerciseList[index],
                      //     ),
                      //   ),
                      // );
                    },
                    child: ExerciseCard(
                        exerciseList: state.exerciseList, exerciseIdx: index),
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
