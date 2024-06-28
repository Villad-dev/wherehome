import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> notifications = List.generate(
        5, (index) => 'Notification ${index + 1}: Message ${index + 1}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sent Notifications'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text('Notification ${index + 1}'),
                subtitle: Text(notifications[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
