import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF6200EE); // Replace with your desired color
const Color accentColor = Color(0xFF03DAC5); // Replace with your desired color

final ThemeData lightTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    titleLarge: TextStyle(color: Colors.black),
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
  useMaterial3: true,
);

final ThemeData darkTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
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
  useMaterial3: true,
);
