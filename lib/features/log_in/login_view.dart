import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wherehome/common/controllers/http_controller.dart';
import 'package:wherehome/common/widgets/dropdown_countries_list.dart';
import 'package:wherehome/common/widgets/localized_textfield.dart';
import 'package:wherehome/const/countries.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _phone;
  late final TextEditingController _password;
  late int _code;
  final api = HttpController();

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
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
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
                        // final user = User(
                        //     email: 'hello',
                        //     phoneNumber: '$_code${_phone.text}',
                        //     password: _password.text);
                        //
                        // await api.sendPostRequest(
                        //     'auth/basic', jsonEncode(user), (success) {
                        //   user.id = jsonDecode(success.body)['id'];
                        // }, (fail) {});
                        Navigator.pushNamed(context, '/home');
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
