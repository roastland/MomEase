import 'package:flutter/material.dart';
import 'package:momease/src/features/professional_help/presentation/widgets/call_help_button.dart';

class CallHelpCard extends StatelessWidget {
  const CallHelpCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      // color: const Color(0xFFCFE2FF),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "One Call Away",
                // selectionColor: primaryTextColor,
                textAlign: TextAlign.start,
                style: TextStyle(
                    // color: primaryTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Need a hand? Reach out for support",
                // selectionColor: primaryTextColor,
                textAlign: TextAlign.start,
                style: TextStyle(
                    // color: primaryTextColor,
                    fontSize: 14),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Align(
                  alignment: Alignment.centerRight, child: CallHelpButton()),
            ),
          ],
        ),
      ),
    );
  }
}
