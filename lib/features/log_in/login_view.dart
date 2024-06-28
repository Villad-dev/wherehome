import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wherehome/common/inherited_http_controller.dart';
import 'package:wherehome/common/providers/user_provider.dart';
import 'package:wherehome/common/widgets/dialog_error.dart';
import 'package:wherehome/common/widgets/dropdown_countries_list.dart';
import 'package:wherehome/common/widgets/localized_textfield.dart';
import 'package:wherehome/const/countries.dart';
import 'package:wherehome/data/repositories/home_owner_repo.dart';
import 'package:wherehome/data/repositories/user_repo.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _phone;
  late final TextEditingController _password;
  late int _code;

  @override
  void initState() {
    _phone = TextEditingController();
    _password = TextEditingController();
    _code = countries['Poland']!.dialCode;
    super.initState();
  }

  @override
  void dispose() {
    _phone.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final api = HttpControllerInherited.of(context).api;
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
                'assets/images/login_image.png',
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
                      'mobile_request_help'.tr(), // Check localization
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
                      'verification_code_help'.tr(), // Check localization
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
                          (value) => null,
                        ),
                      ),
                    ],
                  ),
                  LocalizedTextField(
                    _password,
                    'password_request_help_short',
                    16,
                    TextInputType.visiblePassword,
                    true,
                    (value) => null,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary, // Check color
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Text(
                          'or'.tr(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary, // Check color
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary, // Check color
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'register_question'.tr(),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                          TextSpan(
                            text: 'register_text'.tr(),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(
                                    context, '/register'); // Check navigation
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: OutlinedButton(
                      onPressed: () async {
                        final user = User(phoneNumber: '$_code${_phone.text}');

                        api.sendGetRequest(
                            'auth/bearer', user.toJson(_password.text),
                            (success) async {
                          final response = jsonDecode(success.body);
                          user.id = response['userId'];
                          user.email = response['email'];
                          final token = response['token'];
                          final userProvider =
                              Provider.of<UserProvider>(context, listen: false);
                          userProvider.setUser(user, token);

                          await api.sendGetRequest('homeowner', {
                            'Authorization': 'Bearer $token',
                            'userId': user.id!,
                          }, (onSuccess) {
                            final jsonResponse = jsonDecode(onSuccess.body);
                            userProvider
                                .setHomeOwner(HomeOwner.fromJson(jsonResponse));
                            Navigator.pushNamed(context, '/home');
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
                        "Where's Home",
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
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
