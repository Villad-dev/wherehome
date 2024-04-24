import 'dart:core';

import 'package:flutter/material.dart';
import 'package:wherehome/features/views/login_view.dart';
import 'package:wherehome/util/themes/main_theme.dart';
import 'features/views/home_view.dart';

void main() {
  // runs the WhereHome application
  runApp(const WhereHome());
}

class WhereHome extends StatelessWidget {
  const WhereHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightColorTheme,
      home: const LoginView(),
      //home: const HomeView(title: 'Hello WhereHome'),
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const LoginView(), // TODO
        '/items': (context) => const HomeView(title: 'Tittle'),
      },
    );
  }
}