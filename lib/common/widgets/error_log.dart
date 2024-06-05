import 'package:flutter/material.dart';

class ErrorLogText extends StatelessWidget {
  final bool hasProblems;
  final String message;

  const ErrorLogText(
      {super.key, required this.hasProblems, required this.message});

  @override
  Widget build(BuildContext context) {
    return hasProblems
        ? Text(
            message,
            style: const TextStyle(color: Colors.red),
          )
        : const SizedBox(); // Empty widget when there are no problems
  }
}
