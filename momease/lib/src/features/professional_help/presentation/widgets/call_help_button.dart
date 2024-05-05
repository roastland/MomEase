import 'package:flutter/material.dart';

class CallHelpButton extends StatefulWidget {
  const CallHelpButton({super.key});

  @override
  State<CallHelpButton> createState() => _CallHelpButtonState();
}

class _CallHelpButtonState extends State<CallHelpButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.call),
        label: const Text("Call Now"));
  }
}
