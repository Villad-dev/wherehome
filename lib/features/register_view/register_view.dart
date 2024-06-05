import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wherehome/common/controllers/http_controller.dart';
import 'package:wherehome/common/widgets/dialog_error.dart';
import 'package:wherehome/common/widgets/dropdown_countries_list.dart';
import 'package:wherehome/common/widgets/error_log.dart';
import 'package:wherehome/common/widgets/localized_textfield.dart';
import 'package:wherehome/const/countries.dart';
import 'package:wherehome/data/models/ErrorLog.dart';
import 'package:wherehome/data/repositories/user_repo.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _phone;
  late final TextEditingController _password;
  late final TextEditingController _email;
  late final TextEditingController _confirmPassword;
  late final int _code;
  final api = HttpController();
  final _errorLog = ErrorLog(
      errorMessage: '', errorEmptyFields: false, errorPasswords: false);

  @override
  void initState() {
    _phone = TextEditingController();
    _password = TextEditingController();
    _email = TextEditingController();
    _confirmPassword = TextEditingController();
    _code = countries['Poland']!.dialCode;
    validateFields();
    super.initState();
  }

  @override
  void dispose() {
    _phone.dispose();
    _password.dispose();
    _email.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void validateFields() {
    setState(() {
      _errorLog.errorMessage = '';
      _errorLog.errorEmptyFields = _phone.text.isEmpty ||
          _password.text.isEmpty ||
          _confirmPassword.text.isEmpty ||
          _email.text.isEmpty;

      print(_errorLog.errorEmptyFields);
      if (_errorLog.errorEmptyFields) {
        _errorLog.errorMessage += 'Please fill in all required fields';
      }

      _errorLog.errorPasswords = _password.text != _confirmPassword.text;
      if (_errorLog.errorPasswords) {
        _errorLog.errorMessage += ' Passwords do not match. Try again!';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Ensure keyboard resize behavior
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 200,
              width: double.maxFinite,
              child: Image.asset(
                'assets/images/register_image.png', // Change image if needed
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 30,
                    child: Text(
                      'register_help'.tr(), // Check localization
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 100,
                    child: Text(
                      'register_description'.tr(), // Check localization
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropDownCountriesList(
                        onCodeChanged: (code) {
                          setState(() {
                            _code = code;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: LocalizedTextField(
                          _phone,
                          'mobile_request_help_short',
                          10,
                          TextInputType.phone,
                          false,
                          (value) => validateFields(),
                        ),
                      ),
                    ],
                  ),
                  LocalizedTextField(
                    _email,
                    'email_request_help_short',
                    50,
                    TextInputType.emailAddress,
                    false,
                    (value) => validateFields(),
                  ),
                  LocalizedTextField(
                    _password,
                    'password_request_help_short',
                    16,
                    TextInputType.visiblePassword,
                    false,
                    (value) => validateFields(),
                  ),
                  LocalizedTextField(
                    _confirmPassword,
                    'confirm_password_request_help_short',
                    16,
                    TextInputType.visiblePassword,
                    false,
                    (value) => validateFields(),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'login_question'.tr(),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                        TextSpan(
                          text: 'login_text'.tr(),
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/login');
                            },
                        ),
                      ],
                    ),
                  ),
                  ErrorLogText(
                    hasProblems:
                        _errorLog.errorPasswords || _errorLog.errorEmptyFields,
                    message: _errorLog.errorMessage,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: OutlinedButton(
                      onPressed: () async {
                        final user = User(
                            email: _email.text,
                            phoneNumber: int.parse('$_code${_phone.text}'),
                            password: _password.text);

                        await api.sendPostRequest(
                            'auth/basic', jsonEncode(user), (success) {
                          user.id = jsonDecode(success.body)['id'];
                          Navigator.of(context).pop();
                        }, (fail) {
                          showErrorDialog(context, fail.body);
                        });
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            const Size(double.maxFinite, 60)),
                        maximumSize: MaterialStateProperty.all(
                            const Size(double.maxFinite, 150)),
                      ),
                      child: Text(
                        'register_button_text'.tr(),
                        style: TextStyle(
                          fontSize: 22,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary, // Check color
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
