import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SwitchPropertyType extends StatefulWidget {
  const SwitchPropertyType({super.key, required this.onSwitched});

  final Function(String buildingType) onSwitched;

  @override
  State<SwitchPropertyType> createState() => _SwitchPropertyTypeState();
}

class _SwitchPropertyTypeState extends State<SwitchPropertyType> {
  late List<bool> types;

  @override
  void initState() {
    types = List.filled(7, false)..[0] = true;
    super.initState();
  }

  List<String> propertyTypeLabels = [
    'Apartment',
    'Condos',
    'House',
    'Office',
    'Garage',
    'Land',
    'Other'
  ];

  void selectPropertyType(int selectedIndex) {
    setState(() {
      types.fillRange(0, types.length, false);
      types[selectedIndex] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 10,
      alignment: WrapAlignment.center,
      children: types.asMap().entries.map((entry) {
        int index = entry.key;
        bool isSelected = types[index];
        String text = propertyTypeLabels[index];

        return TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              return isSelected ? theme.surface : theme.onBackground;
            }),
          ),
          onPressed: () {
            selectPropertyType(index);
            widget.onSwitched(propertyTypeLabels[index]);
          },
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ).tr(),
        );
      }).toList(),
    );
  }
}
