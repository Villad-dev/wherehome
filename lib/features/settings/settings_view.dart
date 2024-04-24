import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

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
            onTap: () {
              // Navigate to the theme settings screen
              // You can implement this navigation logic here
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Notifications'),
            subtitle: const Text('Enable or disable notifications'),
            leading: const Icon(Icons.notifications),
            onTap: () {
              // Navigate to the notifications settings screen
              // You can implement this navigation logic here
            },
          ),
          const Divider(),
          // Add more settings as needed
        ],
      ),
    );
  }
}
