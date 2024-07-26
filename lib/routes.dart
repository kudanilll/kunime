import 'package:flutter/material.dart';
import 'package:kunime/screens/auth/login_screen.dart';
import 'package:kunime/screens/auth/register_screen.dart';
import 'package:kunime/screens/splash_screen.dart';
import 'package:kunime/screens/home_screen.dart';

class Routes {
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/auth/login';
  static const String register = '/auth/register';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
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
