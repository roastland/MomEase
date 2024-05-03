import 'package:flutter/material.dart';

class DailyMotivationCard extends StatelessWidget {
  const DailyMotivationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        // color: const Color(0xFFCFE2FF),
        // TODO: use daily motivation API to change each time
        child: Container(
            // padding: const EdgeInsets.all(4),
            child: const ListTile(
          leading: Icon(Icons.report),
          title: Text(
            "Friendly Reminder",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          subtitle: Text(
              "Remember to prioritize your needs, mama. Taking care of yourself is taking care of your baby too."),
          // isThreeLine: true,
        )));
  }
}
