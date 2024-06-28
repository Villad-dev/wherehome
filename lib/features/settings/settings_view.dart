import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'widgets/language_dialog.dart';
import 'widgets/theme_toggle.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  void _showLanguageSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return LanguageSelectionDialog(onLocaleSelected: (locale) {
          context.setLocale(locale);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('settings').tr(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const ThemeToggleWidget(),
          const Divider(),
          ListTile(
            title: const Text('notifications').tr(),
            subtitle: const Text('notifications_descriptions').tr(),
            leading: const Icon(Icons.notifications),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const Text('language').tr(),
            subtitle: const Text('language_description').tr(),
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
