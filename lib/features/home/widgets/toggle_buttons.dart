import 'package:flutter/material.dart';

class ToggleButtonsExample extends StatelessWidget {
  final bool isGrid;
  final VoidCallback onToggleGrid;
  final VoidCallback onToggleList;

  const ToggleButtonsExample({
    super.key,
    required this.isGrid,
    required this.onToggleGrid,
    required this.onToggleList,
  });

  @override
  Widget build(BuildContext context) {
    final mainColor = Theme.of(context).colorScheme.surface;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onToggleList,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: !isGrid ? mainColor : Colors.transparent,
            ),
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.list,
              color: !isGrid ? Colors.white : Colors.black,
            ),
          ),
        ),
        SizedBox(width: 16), // Add space between the buttons
        GestureDetector(
          onTap: onToggleGrid,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isGrid ? mainColor : Colors.transparent,
            ),
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.grid_on_outlined,
              color: isGrid ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
