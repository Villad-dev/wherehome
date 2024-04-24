import 'package:flutter/material.dart';

class HomeItemView extends StatelessWidget {
  const HomeItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Home Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Address: ul. Piotrokowska 123',
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              'Price: 2000 zl',
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              'Landlord Details:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/landlord_avatar.jpg'),
            ),
            const SizedBox(height: 8),
            const Text(
              'Name: John Doe',
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              'Phone: +1234567890',
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              'Email: johndoe@example.com',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Add functionality to check available hours for observation
              },
              child: const Text('Check Available Hours'),
            ),
          ],
        ),
      ),
    );
  }
}
