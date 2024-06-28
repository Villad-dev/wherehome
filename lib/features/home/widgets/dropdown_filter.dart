import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FiltersWidget extends StatefulWidget {
  const FiltersWidget({super.key, required this.onFilterApplied});

  final void Function(String) onFilterApplied;

  @override
  State<FiltersWidget> createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersWidget> {
  String selectedFilter = 'newest';

  List<DropdownMenuItem<String>> filters = [
    DropdownMenuItem(value: 'newest', child: Text('newest_homes'.tr())),
    DropdownMenuItem(value: 'asc_price', child: Text('asc_price'.tr())),
    DropdownMenuItem(value: 'desc_price', child: Text('desc_price'.tr())),
    DropdownMenuItem(value: 'asc_area', child: Text('asc_area'.tr())),
    DropdownMenuItem(value: 'desc_area', child: Text('desc_area'.tr())),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DropdownButton<String>(
      value: selectedFilter,
      hint: Text(
        'sorting_type'.tr(),
      ),
      icon: Icon(
        Icons.arrow_downward,
        color: colorScheme.onSecondary,
      ),
      iconSize: 24,
      elevation: 16,
      underline: Container(
        height: 2,
        color: colorScheme.surface,
      ),
      onChanged: (newValue) {
        setState(() {
          selectedFilter = newValue!;
          widget.onFilterApplied(selectedFilter);
        });
      },
      items: filters,
    );
  }
}
