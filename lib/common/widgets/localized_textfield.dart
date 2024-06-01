import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizedTextField extends StatelessWidget {
  const LocalizedTextField(this.textController, this.textHint, {super.key});

  final TextEditingController textController;
  final String textHint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 10,
      controller: textController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        hintText: textHint.tr(),
      ),
    );
  }
}
