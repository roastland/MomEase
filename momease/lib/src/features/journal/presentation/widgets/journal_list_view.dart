import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momease/src/features/journal/presentation/bloc/journal_bloc.dart';

class JournalListView extends StatefulWidget {
  const JournalListView({super.key});

  @override
  State<JournalListView> createState() => _JournalListViewState();
}

class _JournalListViewState extends State<JournalListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<JournalBloc>(context),
      builder: (context, state) {
        if (state is JournalInitial) {
          BlocProvider.of<JournalBloc>(context).add(FetchJournalList());
          return const Center(child: CircularProgressIndicator());
        } else if (state is JournalLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is JournalLoaded) {
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.journalList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.journalList[index].title),
                  subtitle: Text(state.journalList[index].journalText),
                );
              });
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
