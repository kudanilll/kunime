import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF6200EE);
const Color accentColor = Color(0xFF03DAC5);

final ThemeData globalTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white, fontFamily: 'Coolvetica'),
    titleLarge: TextStyle(color: Colors.white, fontFamily: 'Coolvetica'),
  ),
  searchViewTheme: SearchViewThemeData(backgroundColor: Colors.grey[900]),
  colorScheme: const ColorScheme.dark(
    primary: primaryColor,
    secondary: accentColor,
  ).copyWith(secondary: accentColor),
  fontFamily: 'CreatoDisplay',
  useMaterial3: true,
);
