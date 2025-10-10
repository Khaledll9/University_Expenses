import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'LamaSans',
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.grey[700],
    selectionHandleColor: Colors.grey[700],
  ),
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    onSurface: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    onPrimary: Colors.grey.shade300,
    secondary: Colors.grey.shade600,
    onSecondary: Colors.grey.shade100,
    primaryContainer: Colors.grey.shade100,
    onPrimaryContainer: Colors.grey.shade700,
    inversePrimary: Colors.grey.shade200,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'LamaSans',
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.grey[300],
    selectionHandleColor: Colors.grey[300],
  ),

  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    onSurface: Colors.grey.shade300,
    primary: Colors.grey.shade300,
    onPrimary: Colors.grey.shade800,
    secondary: Colors.grey.shade100,
    onSecondary: Colors.grey.shade600,
    primaryContainer: Colors.grey.shade700,
    onPrimaryContainer: Colors.grey.shade100,
    inversePrimary: Colors.grey.shade800,
  ),
);
