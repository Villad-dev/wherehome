import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:wherehome/features/home_insertion/inserthome_view.dart';
import 'package:wherehome/features/log_in/login_view.dart';
import 'package:wherehome/features/phone_validation/phone_verification.dart';
import 'package:wherehome/util/themes/main_theme.dart';
import 'features/home/home_view.dart';

void main(){
  runApp(const WhereHome());
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
      /*.copyWith(
        toggleButtonsTheme: lightColorTheme.toggleButtonsTheme,
      ),*/
      home: const LoginView(),
      //home: const HomeView(title: 'Hello WhereHome'),
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const LoginView(),
        '/home': (context) => const HomeView(title: 'Tittle'),
        '/home/insert_new_home': (context) => const InsertHome(),
        '/login/validation' : (context) => const PhoneValidation(),
      },
    );
  }
}