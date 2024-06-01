import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wherehome/common/widgets/dropdown_countries_list.dart';
import 'package:wherehome/common/widgets/hover_icon_button.dart';
import 'package:wherehome/common/widgets/localized_textfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _phone;
  late final TextEditingController _password;

  @override
  void initState() {
    _phone = TextEditingController();
    _password = TextEditingController();
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
                      const DropDownCountriesList(),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: LocalizedTextField(
                          _phone,
                          'mobile_request_help_short',
                        ),
                      ),
                    ],
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
                    padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        HoverIconButton(
                          onPressed: () {
                            // TODO: Implement Google login
                          },
                          icon: Image.asset(
                              'assets/icons/google.png'), // Check image path
                        ),
                        HoverIconButton(
                          onPressed: () {
                            // TODO: Implement Apple login
                          },
                          icon: Image.asset(
                              'assets/icons/apple.png'), // Check image path
                        ),
                        HoverIconButton(
                          onPressed: () {
                            // TODO: Implement Facebook login
                          },
                          icon: Image.asset(
                              'assets/icons/facebook.png'), // Check image path
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, '/login/validation'); // Check navigation
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
          ],
        ),
      ),
    );
  }
}
