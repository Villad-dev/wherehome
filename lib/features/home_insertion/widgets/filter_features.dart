import 'package:flutter/material.dart';

class FilterFeatures extends StatefulWidget {
  const FilterFeatures({super.key});

  @override
  State<FilterFeatures> createState() => _FilterFeaturesState();
}

class _FilterFeaturesState extends State<FilterFeatures> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      label: const Text('Features'),
      icon: const Icon(Icons.filter_alt_outlined),
    );
  }
}
