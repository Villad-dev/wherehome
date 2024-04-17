import 'package:flutter/material.dart';

import '../../main.dart';
import 'home_view.dart';

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
      body: Column(
        children: [
          const Image(image: AssetImage('assets/images/login_image.png'),
          fit: BoxFit.fill,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _phone,
              decoration: const InputDecoration(
                hintText: 'Enter your phone',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
            child: TextField(
              controller: _password,
              decoration: const InputDecoration(
                hintText: 'Enter your password',
              ),
            ),
          ),
          const Spacer(),
          OutlinedButton(
            onPressed: () {
              // TODO
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeView(title: 'HomeView'))); },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(60, 20)),
                maximumSize: MaterialStateProperty.all(const Size(200, 60))),
            child: const Text('Enter'),
          )
        ],
      ),
    );
  }
}
