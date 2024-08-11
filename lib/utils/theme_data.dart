import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF6200EE); // Replace with your desired color
const Color accentColor = Color(0xFF03DAC5); // Replace with your desired color

final ThemeData lightTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: Colors.black,
      fontFamily: 'Coolvetica',
    ),
    titleLarge: TextStyle(
      color: Colors.black,
      fontFamily: 'Coolvetica',
    ),
  ),
  searchViewTheme: SearchViewThemeData(
    backgroundColor: Colors.grey[200],
  ),
  colorScheme: const ColorScheme.light(
    primary: primaryColor,
    secondary: accentColor,
  ).copyWith(
    secondary: accentColor,
  ),
  fontFamily: 'CreatoDisplay',
  useMaterial3: true,
);

final ThemeData darkTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: Colors.white,
      fontFamily: 'Coolvetica',
    ),
    titleLarge: TextStyle(
      color: Colors.white,
      fontFamily: 'Coolvetica',
    ),
  ),
  searchViewTheme: SearchViewThemeData(
    backgroundColor: Colors.grey[900],
  ),
  colorScheme: const ColorScheme.dark(
    primary: primaryColor,
    secondary: accentColor,
  ).copyWith(
    secondary: accentColor,
  ),
  fontFamily: 'CreatoDisplay',
  useMaterial3: true,
);

bool isLightMode(BuildContext context) =>
    Theme.of(context).brightness == Brightness.light;
