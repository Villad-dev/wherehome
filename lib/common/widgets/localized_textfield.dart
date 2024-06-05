import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizedTextField extends StatefulWidget {
  const LocalizedTextField(this.textController, this.textHint, this.length,
      this.inputType, this.isVisible, this.onChanged,
      {super.key});

  final TextEditingController textController;
  final String textHint;
  final int length;
  final TextInputType inputType;
  final bool isVisible;
  final Function(dynamic value) onChanged;

  @override
  _LocalizedTextFieldState createState() => _LocalizedTextFieldState();
}

class _LocalizedTextFieldState extends State<LocalizedTextField> {
  bool _isObscured = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: widget.length,
      controller: widget.textController,
      obscureText: widget.isVisible ? _isObscured : false,
      keyboardType: widget.inputType,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        hintText: widget.textHint.tr(),
        suffixIcon: widget.isVisible
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null,
      ),
    );
  }
}
