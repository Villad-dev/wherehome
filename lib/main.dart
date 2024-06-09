import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:wherehome/features/home_insertion/inserthome_view.dart';
import 'package:wherehome/features/log_in/login_view.dart';
import 'package:wherehome/features/phone_validation/phone_verification.dart';
import 'package:wherehome/features/register_view/register_view.dart';
import 'package:wherehome/util/themes/main_theme.dart';

import 'const/languages.dart';
import 'features/home/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final Languages languages = Languages();
  final supported = languages.getSupportedLocales();
  runApp(
    EasyLocalization(
      supportedLocales: supported,
      fallbackLocale: supported[0],
      path: 'assets/i18n',
      child: const WhereHome(),
    ),
  );
  const token = String.fromEnvironment('SDK_REGISTRY_TOKEN');
  MapboxOptions.setAccessToken(token);
}

class WhereHome extends StatelessWidget {
  const WhereHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightColorTheme,
      home: const HomeView(title: 'Tittle'),
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
        '/home': (context) => const HomeView(title: 'Tittle'),
        '/home/insert_new_home': (context) => const InsertHome(),
        '/login/validation': (context) => const PhoneValidation(),
      },
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
