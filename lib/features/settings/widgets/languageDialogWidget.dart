import 'package:flutter/material.dart';

class LanguageSelectionDialog extends StatelessWidget {
  final Function(Locale) onLocaleSelected;

  const LanguageSelectionDialog({super.key, required this.onLocaleSelected});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 16,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Select Language',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
