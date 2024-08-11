import 'package:flutter/material.dart';
import 'package:kunime/screens/auth/auth_widzard.dart';
import 'package:kunime/screens/auth/login_screen.dart';
import 'package:kunime/screens/auth/register_screen.dart';
import 'package:kunime/screens/splash_screen.dart';
import 'package:kunime/screens/home_screen.dart';

class Routes {
  static const String splash = '/';
  static const String home = '/home';

  // authentication screen
  static const String widzard = '/auth';
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String verify = '/auth/verify';
  static const String forgotPassword = '/auth/forgot-password';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case widzard:
        return MaterialPageRoute(builder: (_) => const AuthWidzardScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Route tidak ditemukan: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
