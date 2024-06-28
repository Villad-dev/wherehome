import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizedTextField extends StatefulWidget {
  const LocalizedTextField(this.textController, this.textHint, this.length,
      this.inputType, this.isPassword, this.onChanged,
      {super.key});

  final TextEditingController textController;
  final String textHint;
  final int length;
  final TextInputType inputType;
  final bool isPassword;
  final Function(dynamic value) onChanged;

  @override
  LocalizedTextFieldState createState() => LocalizedTextFieldState();
}

class LocalizedTextFieldState extends State<LocalizedTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: widget.length,
      controller: widget.textController,
      obscureText: _isObscured,
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
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onLongPressDown: (_) {
                  setState(() {
                    _isObscured = false; // Show the password
                  });
                },
                onLongPressCancel: () {
                  setState(() {
                    _isObscured = true; // Hide the password
                  });
                },
                onLongPressEnd: (_) {
                  setState(() {
                    _isObscured = true; // Hide the password
                  });
                },
                child: Icon(
                  _isObscured ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : null,
      ),
    );
  }
}
