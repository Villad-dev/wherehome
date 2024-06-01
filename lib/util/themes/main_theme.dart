import 'package:flutter/material.dart';

final ThemeData lightColorTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    background: Color.fromARGB(255, 242, 249, 251),
    onBackground: Color.fromARGB(255, 78, 81, 82),
    primary: Color.fromARGB(255, 78, 81, 82),
    onPrimary: Color.fromARGB(255, 30, 30, 30),
    primaryContainer: Color.fromARGB(244, 25, 60, 104),
    onPrimaryContainer: Color.fromARGB(244, 181, 200, 227),
    secondary: Color.fromARGB(244, 25, 60, 104),
    onSecondary: Color.fromARGB(244, 223, 132, 56),
    error: Color.fromARGB(244, 255, 0, 78),
    onError: Color.fromARGB(244, 255, 255, 255),
    surface: Color.fromARGB(244, 171, 199, 230),
    onSurface: Color.fromARGB(244, 31, 32, 31),
    tertiaryContainer: Color.fromARGB(255, 190, 231, 255),
    onTertiaryContainer: Color.fromARGB(244, 8, 13, 47),
  ),
  toggleButtonsTheme: ToggleButtonsThemeData(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
    ),
    color: const Color.fromARGB(255, 190, 190, 190),
    selectedColor: const Color.fromARGB(255, 193, 219, 255),
    disabledColor: Colors.grey,
    fillColor: Colors.blue.withOpacity(0.2),
    focusColor: Colors.blueAccent,
    highlightColor: Colors.blueAccent.withOpacity(0.5),
    hoverColor: Colors.blueAccent.withOpacity(0.5),
    splashColor: Colors.blueAccent.withOpacity(0.5),
    borderColor: Colors.blue,
    selectedBorderColor: Colors.lightBlue,
    disabledBorderColor: Colors.grey,
    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
    borderWidth: 1.0,
  ),
  fontFamily: 'Inter',
  primaryColor: const Color.fromARGB(145, 46, 148, 255),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: const TextStyle(color: Colors.grey),
    errorStyle: const TextStyle(color: Colors.red),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(color: Colors.black87),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(color: Colors.blue),
    ),
  ),
);

// Dark color theme
final ThemeData darkColorTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color.fromARGB(244, 31, 32, 31),
    onPrimary: Color.fromARGB(244, 232, 232, 232),
    secondary: Color.fromARGB(244, 25, 60, 104),
    onSecondary: Color.fromARGB(244, 225, 239, 255),
    error: Color.fromARGB(244, 255, 0, 78),
    background: Color.fromARGB(244, 38, 38, 38),
    surface: Color.fromARGB(244, 0, 234, 255),
    onError: Color.fromARGB(244, 232, 203, 214),
    onBackground: Color.fromARGB(244, 168, 175, 168),
    onSurface: Color.fromARGB(244, 255, 255, 255),
  ),
  fontFamily: 'KodeMono',
  primaryColor: Colors.black,
);
