import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:wherehome/features/home_insertion/inserthome_view.dart';
import 'package:wherehome/features/log_in/login_view.dart';
import 'package:wherehome/features/phone_validation/phone_verification.dart';
import 'package:wherehome/util/themes/main_theme.dart';

import 'features/home/home_view.dart';

void main() {
  runApp(const WhereHome());
  const token = String.fromEnvironment('SDK_REGISTRY_TOKEN');
  MapboxOptions.setAccessToken(token);
}

class WhereHome extends StatelessWidget {
  const WhereHome({super.key});

  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];

    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        LocalJsonLocalization.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('uk', 'UK'),
        Locale('pl', 'PL'),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (supportedLocales.contains(locale)) {
          return locale;
        }
        return const Locale('uk', 'UK');
      },
      locale: const Locale('pl', 'PL'),
      title: 'Flutter Demo',
      theme: lightColorTheme,
      home: const LoginView(),
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const LoginView(),
        '/home': (context) => const HomeView(title: 'Tittle'),
        '/home/insert_new_home': (context) => const InsertHome(),
        '/login/validation': (context) => const PhoneValidation(),
      },
    );
  }
}
