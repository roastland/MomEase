import 'package:flutter/material.dart';
import 'package:momease/src/features/journal/presentation/widgets/add_journal_button.dart';
import 'package:momease/src/features/journal/presentation/widgets/journal_search_bar.dart';
import 'package:momease/src/features/journal/presentation/widgets/mood_difference_card.dart';
import 'package:momease/src/features/journal/presentation/widgets/mood_tracking_card.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Your Mood This Month",
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
                child: MoodTrackingCard()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Latest",
                  // selectionColor: primaryTextColor,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      // color: primaryTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: MoodDifferenceCard(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Journals",
                    // selectionColor: primaryTextColor,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        // color: primaryTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 28, child: AddJournalButton()),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: SizedBox(height: 45, child: JournalSearchBar()),
            ),
          ],
        ),
      ),
    );
  }
}
