import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EmptyProfile extends StatelessWidget {
  const EmptyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "register_question",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ).tr(),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('login_text').tr()),
            const SizedBox(
              width: 40,
            ),
            OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('register_button_text').tr()),
          ],
        ),
      ],
    );
  }
}
