import 'package:flutter/material.dart';

class ThemeDataStyle {

  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      surface: Colors.white
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      surface: Colors.black,
      primary: Colors.grey[900]!,
      secondary: Colors.grey[800]!

    ),
  );

}