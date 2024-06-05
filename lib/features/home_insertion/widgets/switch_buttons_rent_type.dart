import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SwitchHomeType extends StatefulWidget {
  const SwitchHomeType({super.key});

  @override
  State<SwitchHomeType> createState() => _SwitchHomeTypeState();
}

class _SwitchHomeTypeState extends State<SwitchHomeType> {
  late List<bool> homeType = [true, false];

  @override
  void initState() {
    homeType = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      constraints: BoxConstraints(
        maxHeight: 55,
        //maxWidth: double.maxFinite,
        minHeight: 40,
        minWidth: (MediaQuery.of(context).size.width - 50) / 2,
      ),
      isSelected: homeType,
      children: [
        const Text('add_rent').tr(),
        const Text('add_sell').tr(),
      ],
      onPressed: (int index) {
        setState(() {
          switchToggle(index);
        });
      },
    );
  }

  void switchToggle(int selectedIndex) {
    for (int buttonIndex = 0; buttonIndex < homeType.length; buttonIndex++) {
      if (buttonIndex == selectedIndex) {
        homeType[buttonIndex] = true;
      } else {
        homeType[buttonIndex] = false;
      }
    }
  }
}
