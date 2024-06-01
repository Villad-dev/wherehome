import 'package:flutter/material.dart';

import 'widgets/languageDialogWidget.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  void _showLanguageSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return LanguageSelectionDialog(
          onLocaleSelected: (locale) {
            // Here you need to implement the code to change the app's locale
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('Theme'),
            subtitle: const Text('Change the app theme'),
            leading: const Icon(Icons.palette),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const Text('Notifications'),
            subtitle: const Text('Enable or disable notifications'),
            leading: const Icon(Icons.notifications),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const Text('Language'),
            subtitle: const Text('Change the app default language'),
            leading: const Icon(Icons.language),
            onTap: () {
              _showLanguageSelectionDialog(context);
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
