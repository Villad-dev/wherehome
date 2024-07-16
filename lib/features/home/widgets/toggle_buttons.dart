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
    final mainColor = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onToggleList,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: !isGrid ? mainColor.surface : Colors.transparent,
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(
              Icons.list,
              color: !isGrid ? mainColor.onPrimary : mainColor.primary,
            ),
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: onToggleGrid,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isGrid ? mainColor.surface : Colors.transparent,
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(
              Icons.grid_on_outlined,
              color: isGrid ? mainColor.onPrimary : mainColor.primary,
            ),
          ),
        ),
      ],
    );
  }
}
