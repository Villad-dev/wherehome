import 'package:flutter/material.dart';

class SwitchButtonsRooms extends StatefulWidget {
  const SwitchButtonsRooms({super.key, required this.onSwitched});

  final Function(int number) onSwitched;

  @override
  State<SwitchButtonsRooms> createState() => _SwitchButtonsRoomsState();
}

class _SwitchButtonsRoomsState extends State<SwitchButtonsRooms> {
  late final List<bool> buttons;

  @override
  void initState() {
    buttons = [true, false, false, false, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: buttons,
      children: const [
        Text('1'),
        Text('2'),
        Text('3'),
        Text('4'),
        Text('>5'),
      ],
      onPressed: (int index) {
        setState(() {
          buttons.fillRange(0, buttons.length, false);
          buttons[index] = true;
          widget.onSwitched(index);
        });
      },
    );
  }
}
