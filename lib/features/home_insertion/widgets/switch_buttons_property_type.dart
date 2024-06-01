import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SwitchPropertyType extends StatefulWidget {
  const SwitchPropertyType({super.key});

  @override
  State<SwitchPropertyType> createState() => _SwitchPropertyTypeState();
}

class _SwitchPropertyTypeState extends State<SwitchPropertyType> {
  final customTheme = const ToggleButtonsThemeData(
    textStyle: TextStyle(color: Colors.white),
    color: Color.fromARGB(244, 0, 51, 255),
    selectedColor: Color.fromARGB(244, 0, 255, 255),
    disabledColor: Color.fromARGB(244, 161, 161, 161),
    fillColor: Color.fromARGB(44, 0, 51, 255),
    focusColor: Color.fromARGB(244, 0, 149, 255),
    highlightColor: Color.fromARGB(244, 238, 0, 255),
    hoverColor: Color.fromARGB(244, 238, 0, 255),
    splashColor: Color.fromARGB(244, 238, 0, 255),
    borderColor: Color.fromARGB(244, 0, 149, 255),
    selectedBorderColor: Color.fromARGB(244, 0, 149, 255),
    disabledBorderColor: Color.fromARGB(244, 161, 161, 161),
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
    borderWidth: 2.0,
  );

  late List<bool> types;

  @override
  void initState() {
    types = [true, false, false, false, false, false, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtonsTheme(
      data: customTheme,
      child: ToggleButtons(
        isSelected: types,
        onPressed: (int index) {
          setState(() {
            types.fillRange(0, types.length, false);
            types[index] = true;
          });
        },
        children: [
          const Text('add_property_type_1').tr(),
          const Text('add_property_type_2').tr(),
          const Text('add_property_type_3').tr(),
          const Text('add_property_type_4').tr(),
          const Text('add_property_type_5').tr(),
          const Text('add_property_type_6').tr(),
          const Text('add_property_type_7').tr(),
        ],
      ),
    );
  }
}
