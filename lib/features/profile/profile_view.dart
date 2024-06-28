import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wherehome/features/settings/settings_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('profile').tr(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsView()),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: child,
    );
  }
}
