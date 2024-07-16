import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wherehome/common/inherited_http_controller.dart';
import 'package:wherehome/common/providers/user_provider.dart';
import 'package:wherehome/common/widgets/dialog_error.dart';
import 'package:wherehome/common/widgets/dropdown_countries_list.dart';
import 'package:wherehome/common/widgets/error_log.dart';
import 'package:wherehome/common/widgets/localized_textfield.dart';
import 'package:wherehome/const/countries.dart';
import 'package:wherehome/data/models/error_log.dart';
import 'package:wherehome/data/repositories/home_owner_repo.dart';
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
  late int _code;
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

      if (_errorLog.errorEmptyFields) {
        _errorLog.errorMessage += 'registration_error_1'.tr();
      }

      _errorLog.errorPasswords = _password.text != _confirmPassword.text;
      if (_errorLog.errorPasswords) {
        _errorLog.errorMessage += 'registration_error_2'.tr();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final api = HttpControllerInherited.of(context).api;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 200,
              width: double.maxFinite,
              child: Image.asset(
                'assets/images/register_image.png',
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
                      'register_help'.tr(),
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
                      'register_description'.tr(),
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
                          key: const Key('Registration phone'),
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
                    key: const Key('Registration email'),
                    _email,
                    'email_request_help_short',
                    50,
                    TextInputType.emailAddress,
                    false,
                    (value) => validateFields(),
                  ),
                  LocalizedTextField(
                    key: const Key('Registration password'),
                    _password,
                    'password_request_help_short',
                    16,
                    TextInputType.visiblePassword,
                    true,
                    (value) => validateFields(),
                  ),
                  LocalizedTextField(
                    key: const Key('Registration confirm password'),
                    _confirmPassword,
                    'confirm_password_request_help_short',
                    16,
                    TextInputType.visiblePassword,
                    true,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ErrorLogText(
                      hasProblems: _errorLog.errorPasswords ||
                          _errorLog.errorEmptyFields,
                      message: _errorLog.errorMessage,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: OutlinedButton(
                      key: const Key('Register button'),
                      onPressed: () async {
                        final user = User(
                            email: _email.text,
                            phoneNumber: '$_code${_phone.text}');
                        final userProvider =
                            Provider.of<UserProvider>(context, listen: false);

                        await api.sendPostRequest('auth/bearer', null,
                            user.toJsonWithEmail(_email.text, _password.text),
                            (success) async {
                          final response = jsonDecode(success.body);
                          user.id = response['id'];
                          await api.sendPostRequest(
                              'homeowner', null, user.toHomeOwner(),
                              (onSuccess) async {
                            final responseJson = jsonDecode(onSuccess.body);
                            final homeOwner = HomeOwner.fromJson(responseJson);
                            userProvider.setHomeOwner(homeOwner);
                            Navigator.pushNamed(context, '/login');
                          }, (onFailure) {});
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
                          color: Theme.of(context).colorScheme.onPrimary,
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
