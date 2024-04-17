import 'package:flutter/material.dart';

// Light color theme
final ThemeData lightColorTheme = ThemeData(
  colorScheme: const ColorScheme(
      brightness: Brightness.light,
      background: Color.fromARGB(255, 242, 249, 251),
      onBackground: Color.fromARGB(244, 0, 0, 0),
      primary: Color.fromARGB(244, 51, 51, 51),
      onPrimary: Color.fromARGB(244, 225, 239, 255),
      secondary: Color.fromARGB(244, 25, 60, 104),
      onSecondary: Color.fromARGB(244, 223, 132, 56),
      error: Color.fromARGB(244, 255, 0, 78),
      onError: Color.fromARGB(244, 255, 255, 255),
      surface: Color.fromARGB(244, 171, 199, 230),
      onSurface: Color.fromARGB(244, 31, 32, 31), // All main colors
      tertiaryContainer: Color.fromARGB(244, 174, 121, 220),
      onTertiaryContainer: Color.fromARGB(244, 68, 15, 106),
      primaryContainer: Color.fromARGB(244, 25, 60, 104),
      onPrimaryContainer: Color.fromARGB(244, 141, 54, 160),
      ),

  fontFamily: 'Inter',
  primaryColor: Colors.blue,
);

// Dark color theme
final ThemeData darkColorTheme = ThemeData(
  fontFamily: 'KodeMono',
  primaryColor: Colors.black,
);
