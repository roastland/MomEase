import 'package:flutter/material.dart';
import 'package:momease/src/features/daily_motivation/presentation/widgets/daily_motivation_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello, Georgia!",
                  // selectionColor: primaryTextColor,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      // color: primaryTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                Center(
                  child: DailyMotivationCard(),
                ),
                Text(
                  "Therapy For You",
                  // selectionColor: primaryTextColor,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      // color: primaryTextColor,
                      fontSize: 16),
                ),
                Text(
                  "Exercise For You",
                  // selectionColor: primaryTextColor,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      // color: primaryTextColor,
                      fontSize: 16),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
