import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:provider/provider.dart';
import 'package:wherehome/common/controllers/http_controller.dart';
import 'package:wherehome/common/inherited_http_controller.dart';
import 'package:wherehome/common/providers/theme_provider.dart';
import 'package:wherehome/features/home_insertion/inserthome_view.dart';
import 'package:wherehome/features/log_in/login_view.dart';
import 'package:wherehome/util/themes/main_theme.dart';

import 'common/providers/user_provider.dart';
import 'const/languages.dart';
import 'features/home/home_view.dart';
import 'features/profile/widgets/empty_profile.dart';
import 'features/register/register_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final Languages languages = Languages();
  final supported = languages.getSupportedLocales();
  runApp(
    EasyLocalization(
      supportedLocales: supported,
      path: 'assets/i18n',
      fallbackLocale: supported[0],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const WhereHome(),
      ),
    ),
  );
  const token = String.fromEnvironment('SDK_REGISTRY_TOKEN');
  MapBoxSearch.init(token);
  MapboxOptions.setAccessToken(token);
}

class WhereHome extends StatelessWidget {
  const WhereHome({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final api = HttpController();
    return HttpControllerInherited(
      api: api,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightColorTheme,
        darkTheme: darkColorTheme,
        themeMode: themeProvider.themeMode,
        home: const HomeView(),
        routes: {
          '/login': (context) => const LoginView(),
          '/register': (context) => const RegisterView(),
          '/home': (context) => const HomeView(),
          '/home/insert_new_home': (context) => const HomeInsertion(),
          '/profile': (context) => const EmptyProfile(),
        },
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
