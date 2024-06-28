import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SwitchHomeType extends StatefulWidget {
  final Function(String type) onSwitched;

  const SwitchHomeType({super.key, required this.onSwitched});

  @override
  SwitchHomeTypeState createState() => SwitchHomeTypeState();
}

class SwitchHomeTypeState extends State<SwitchHomeType> {
  List<bool> homeType = [true, false];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ToggleButtons(
        constraints: BoxConstraints(
          maxHeight: 60,
          maxWidth: double.maxFinite,
          minHeight: 45,
          minWidth: (MediaQuery.of(context).size.width - 40) / 2,
        ),
        isSelected: homeType,
        children: [
          const Text(
            'add_rent',
            style: TextStyle(fontSize: 18),
          ).tr(),
          const Text(
            'add_sell',
            style: TextStyle(fontSize: 18),
          ).tr(),
        ],
        onPressed: (int index) {
          setState(() {
            switchToggle(index);
          });
        },
      ),
    );
  }

  void switchToggle(int selectedIndex) {
    for (int buttonIndex = 0; buttonIndex < homeType.length; buttonIndex++) {
      if (buttonIndex == selectedIndex) {
        homeType[buttonIndex] = true;
        widget.onSwitched('Sell');
      } else {
        homeType[buttonIndex] = false;
        widget.onSwitched('Rent');
      }
    }
  }
}
