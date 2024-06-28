import 'package:flutter/material.dart';

class EditableTextWidget extends StatelessWidget {
  final bool isEditing;
  final String initialValue;
  final String hint;
  final TextEditingController controller;
  final TextStyle textStyle;

  const EditableTextWidget({
    super.key,
    required this.isEditing,
    required this.hint,
    required this.initialValue,
    required this.controller,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return isEditing
        ? SizedBox(
            width: 200,
            height: 50,
            child: TextFormField(
              controller: controller,
              style: textStyle,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: hint,
                alignLabelWithHint: true,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        : Text(
            initialValue,
            style: textStyle,
          );
  }
}
