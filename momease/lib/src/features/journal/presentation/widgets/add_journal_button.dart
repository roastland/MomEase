import 'package:flutter/material.dart';
import 'package:momease/src/features/journal/presentation/pages/new_journal_page.dart';

class AddJournalButton extends StatefulWidget {
  const AddJournalButton({super.key});

  @override
  State<AddJournalButton> createState() => _AddJournalButtonState();
}

class _AddJournalButtonState extends State<AddJournalButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewJournalPage(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add New Journal"),
        style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(4),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ))));
  }
}
