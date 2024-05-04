import 'package:flutter/material.dart';

class DailyMotivationCard extends StatelessWidget {
  const DailyMotivationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        // color: const Color(0xFFCFE2FF),
        // TODO: use daily motivation API to change each time
        child: const ListTile(
          leading: Icon(Icons.report),
          title: Text(
            "Friendly Reminder",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          subtitle: Text(
              "Remember to prioritize your needs, mama. Taking care of yourself is taking care of your baby too."),
          // isThreeLine: true,
        ));
  }
}
