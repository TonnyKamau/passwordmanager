import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  fontFamily: 'Poppins',
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade100,
    tertiary: Colors.grey.shade300,
    inversePrimary: Colors.grey.shade200,
    onPrimary: const Color(0xFF1a5f62),
    onTertiary: Colors.black,
  ),
);
