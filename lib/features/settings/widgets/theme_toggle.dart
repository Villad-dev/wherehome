import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wherehome/common/providers/theme_provider.dart';

class ThemeToggleWidget extends StatelessWidget {
  const ThemeToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SwitchListTile(
      title: const Text('Dark Theme'),
      value: themeProvider.themeMode == ThemeMode.dark,
      onChanged: (bool value) {
        themeProvider.toggleTheme(value);
      },
    );
  }
}
