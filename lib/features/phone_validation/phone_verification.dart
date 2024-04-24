import 'package:flutter/material.dart';

import 'widgets/mytextfield.dart';

class PhoneValidation extends StatefulWidget {
  const PhoneValidation({super.key});

  @override
  createState() {
    return _PhoneValidationState();
  }
}

class _PhoneValidationState extends State<PhoneValidation> {
  final FocusNode _firstFocusNode = FocusNode();
  final FocusNode _secondFocusNode = FocusNode();
  final FocusNode _thirdFocusNode = FocusNode();
  final FocusNode _fourthFocusNode = FocusNode();

  late final TextEditingController _firstController;
  late final TextEditingController _secondController;
  late final TextEditingController _thirdController;
  late final TextEditingController _fourthController;

  @override
  void initState() {
    _firstController = TextEditingController();
    _secondController = TextEditingController();
    _thirdController = TextEditingController();
    _fourthController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    _thirdController.dispose();
    _fourthController.dispose();
    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    _thirdFocusNode.dispose();
    _fourthFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Enter the code",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyInputField(
                    controller: _firstController,
                    focusNode: _firstFocusNode,
                    nextFocusNode: _secondFocusNode,
                  ),
                  const SizedBox(width: 10),
                  MyInputField(
                    controller: _secondController,
                    focusNode: _secondFocusNode,
                    nextFocusNode: _thirdFocusNode,
                  ),
                  const SizedBox(width: 10),
                  MyInputField(
                    controller: _thirdController,
                    focusNode: _thirdFocusNode,
                    nextFocusNode: _fourthFocusNode,
                  ),
                  const SizedBox(width: 10),
                  MyInputField(
                    controller: _fourthController,
                    focusNode: _fourthFocusNode,
                    onSubmitted: () {
                      _verifyCode(context);
                    },
                  ),
                ],
              ),
            ),
            TextButton(onPressed: () {
              _verifyCode(context);
            }, child: const Text('Resend code'))
          ],
        ),
      ),
    );
  }

  void _verifyCode(BuildContext context) {
    final code = _firstController.text +
        _secondController.text +
        _thirdController.text +
        _fourthController.text;
    debugPrint('Verifying code: $code');
    Navigator.pushReplacementNamed(context, '/home');
  }
}
