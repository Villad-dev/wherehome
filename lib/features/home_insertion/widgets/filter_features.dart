import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class FilterFeatures extends StatefulWidget {
  const FilterFeatures({
    super.key,
    required this.features,
    required this.onSelectionChanged,
  });

  final List<String> features;
  final Function(List<String>) onSelectionChanged;

  @override
  State<FilterFeatures> createState() => _FilterFeaturesState();
}

class _FilterFeaturesState extends State<FilterFeatures> {
  List<String> _selectedFeatures = [];

  void _openFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Select Filter Features',
            style: TextStyle(fontSize: 16),
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: double.maxFinite,
              // Ensures the content takes full available width
              child: FeatureGrid(
                features: widget.features,
                selectedFeatures: _selectedFeatures,
                onSelectionChanged: (selected) {
                  setState(() {
                    _selectedFeatures = selected;
                  });
                },
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Apply'),
              onPressed: () {
                widget.onSelectionChanged(_selectedFeatures);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: _openFilterDialog,
      label: const Text('Features'),
      icon: const Icon(Icons.filter_alt_outlined),
    );
  }
}

class FeatureGrid extends StatefulWidget {
  const FeatureGrid({
    super.key,
    required this.features,
    required this.selectedFeatures,
    required this.onSelectionChanged,
  });

  final List<String> features;
  final List<String> selectedFeatures;
  final Function(List<String>) onSelectionChanged;

  @override
  State<FeatureGrid> createState() => _FeatureGridState();
}

class _FeatureGridState extends State<FeatureGrid> {
  List<String> _currentSelection = [];

  @override
  void initState() {
    super.initState();
    _currentSelection = List<String>.from(widget.selectedFeatures);
  }

  void _onFeatureTap(String feature) {
    setState(() {
      if (_currentSelection.contains(feature)) {
        _currentSelection.remove(feature);
      } else {
        _currentSelection.add(feature);
      }
      widget.onSelectionChanged(_currentSelection);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      // Prevent inner scroll conflicts
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 120,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2, // Adjust this as needed
      ),
      itemCount: widget.features.length,
      itemBuilder: (context, index) {
        final feature = widget.features[index];
        final isSelected = _currentSelection.contains(feature);
        return GestureDetector(
          onTap: () => _onFeatureTap(feature),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: AutoSizeText(
                textAlign: TextAlign.center,
                feature,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
                maxFontSize: 18,
                minFontSize: 12,
                maxLines: 2,
                // Limit the text to a single line
                overflow: TextOverflow.ellipsis, // Handle overflow
              ),
            ),
          ),
        );
      },
    );
  }
}
