import 'package:flutter/material.dart';

class MyInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final Function()? onSubmitted;

  const MyInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 22,
        fontWeight: FontWeight.w600),
        decoration: const InputDecoration(
          counterText: '',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          if (value.length == 1 && nextFocusNode != null) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          }
        else if(value.length == 1 && nextFocusNode == null && onSubmitted != null){
            onSubmitted!();
          }
        },
        onSubmitted: (_) {
          if (onSubmitted != null) {
            debugPrint("IS NOT NULL!");
            onSubmitted!();
          }
        },
      ),
    );
  }
}
