import 'package:flutter/material.dart';

import '../../common/widgets/dropdown_countries_list.dart';
import '../../common/widgets/hover_icon_button.dart';

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
          const SizedBox(
              height: 200,
              width: double.maxFinite,
              child: Image(
                  image: AssetImage('assets/images/login_image.png'),
                  fit: BoxFit.fill)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Container(
                //Tittle @String Enter your mobile number
                alignment: Alignment.centerLeft,
                height: 30,
                child: const Text('Enter your mobile number',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center),
              ),
              Container(
                //Subtitle @String We'll send you a verification code
                alignment: Alignment.centerLeft,
                height: 50,
                child: const Text("We'll send you a verification code.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center),
              ),
              Row(
                //Dropdown and input field
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropDownCountriesList(
                    context: context,
                  ),
                  Expanded(
                    child: TextField(
                      maxLength: 10,
                      controller: _phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        hintText: 'Enter your phone',
                      ),
                    ),
                  ),
                ],
              ),
              //Splitter with or in the middle
              Row(
                children: [
                  Expanded(
                      child: Divider(
                    color: Theme.of(context).colorScheme.onPrimary,
                  )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Text(
                      "or",
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Theme.of(context).colorScheme.onPrimary,
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
                          //TODO
                        },
                        icon: Image.asset('assets/icons/google.png')),
                    HoverIconButton(
                        onPressed: () {
                          //TODO
                        },
                        icon: Image.asset('assets/icons/apple.png')),
                    HoverIconButton(
                      onPressed: () {
                        //TODO
                      },
                      icon: Image.asset('assets/icons/facebook.png'),
                    )
                  ],
                ),
              ),
              //Where's Home button
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login/validation');
                  },
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          const Size(double.maxFinite, 60)),
                      maximumSize: MaterialStateProperty.all(
                          const Size(double.maxFinite, 150))),
                  child: Text(
                    "Where's Home",
                    style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
