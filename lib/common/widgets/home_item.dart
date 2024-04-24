import 'package:flutter/material.dart';

class HomeItem extends StatelessWidget {
  final String name;

  const HomeItem({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(name),
        subtitle: const Text('Address: ...'),
        onTap: () {},
      ),
    );
  }
}