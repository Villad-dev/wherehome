import 'package:flutter/material.dart';

class HoverIconButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget icon;

  const HoverIconButton({super.key, this.onPressed, required this.icon});

  @override
  _HoverIconButtonState createState() => _HoverIconButtonState();
}
class _HoverIconButtonState extends State<HoverIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.onPressed,
      icon: widget.icon,
      color: Colors.black,
    );
  }
}
