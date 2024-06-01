import 'package:flutter/material.dart';
import 'package:wherehome/const/languages.dart';

class LanguageSelectionDialog extends StatelessWidget {
  final Function(Locale) onLocaleSelected;

  const LanguageSelectionDialog({super.key, required this.onLocaleSelected});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Locale>> languages = Languages().available;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 16,
      child: Container(
        constraints: BoxConstraints(
          maxHeight:
              MediaQuery.of(context).size.height * 0.5, // 50% of screen height
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Select Language',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final locale = languages[index].keys.first;
                  //languages[index].values.first;
                  return ListTile(
                    title: Text(locale.toString()),
                    onTap: () {
                      onLocaleSelected(languages[index].values.first);
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
