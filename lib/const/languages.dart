import 'dart:ui';

class Languages {
  final List<Map<String, Locale>> available = const [
    {'English': Locale('en', 'US')},
    {'Ukrainian': Locale('uk', 'UA')},
    {'Polish': Locale('pl', 'PL')},
  ];

  List<Locale> getSupportedLocales() {
    return available.map((languageMap) => languageMap.values.first).toList();
  }
}
