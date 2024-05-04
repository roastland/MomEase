import 'package:flutter/material.dart';
import 'package:momease/src/features/articles/presentation/widgets/list_of_article_card.dart';
import 'package:momease/src/features/daily_motivation/presentation/widgets/daily_motivation_card.dart';
import 'package:momease/src/features/exercise/presentation/widgets/list_of_exercise_card.dart';
import 'package:momease/src/features/professional_help/presentation/widgets/call_help_card.dart';
import 'package:momease/src/features/therapy/presentation/widgets/list_of_therapy_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Hello, Georgia!",
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
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: DailyMotivationCard(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Therapy For You",
                    // selectionColor: primaryTextColor,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        // color: primaryTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Flexible(child: ListOfTherapyCard()),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Exercise For You",
                    // selectionColor: primaryTextColor,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        // color: primaryTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Flexible(child: ListOfExerciseCard()),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: CallHelpCard(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Articles",
                    // selectionColor: primaryTextColor,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        // color: primaryTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                child: Flexible(child: ListOfArticleCard()),
              ),
            ]),
      ),
    );
  }
}
