import 'package:flutter/material.dart';

final appTheme = ThemeData(
    primaryColor: const Color(0xFFFFFFFF),
    backgroundColor: const Color(0xFFFFFFFF),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Color(0xFF00AB6C),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(const Color(0xFF00AB6C)),
    ),
    appBarTheme: const AppBarTheme(color: Colors.white),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Color(0xFF00AB6C)),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: Color(0xff00AB6C)));
