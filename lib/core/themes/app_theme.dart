import 'package:flutter/material.dart';
import 'app_tokens.dart';

class AppTheme {
  static ThemeData dark() {
    final colorScheme = ColorScheme.dark(
      primary: AppTokens.primary,
      onPrimary: AppTokens.onPrimary,
      secondary: AppTokens.secondary,
      onSecondary: AppTokens.onSecondary,
      surface: AppTokens.background,
      onSurface: AppTokens.onBackground,
      error: AppTokens.error,
      onError: AppTokens.onSemantic,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppTokens.background,
      fontFamily: 'Urbanist',

      appBarTheme: AppBarTheme(
        backgroundColor: AppTokens.background,
        foregroundColor: AppTokens.onBackground,
        elevation: 0,
      ),

      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppTokens.onBackground),
        titleLarge: TextStyle(color: AppTokens.onBackground),
      ),

      searchViewTheme: SearchViewThemeData(
        backgroundColor: AppTokens.secondary.withValues(alpha: .3),
      ),
    );
  }
}
