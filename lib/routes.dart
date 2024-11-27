import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:kunime/screens/auth/auth_wizard.dart';
import 'package:kunime/screens/auth/login_screen.dart';
import 'package:kunime/screens/auth/register_screen.dart';
import 'package:kunime/screens/home_screen.dart';
import 'package:kunime/screens/splash_screen.dart';
=======
import 'package:kunime/screens/auth/auth_widzard.dart';
import 'package:kunime/screens/auth/login_screen.dart';
import 'package:kunime/screens/auth/register_screen.dart';
import 'package:kunime/screens/splash_screen.dart';
import 'package:kunime/screens/home_screen.dart';
>>>>>>> 0a9065c99c02dc8b063f4a742cc31243c113bc56

class Routes {
  static const String splash = '/';
  static const String home = '/home';

  // authentication screen
<<<<<<< HEAD
  static const String wizard = '/auth';
=======
  static const String widzard = '/auth';
>>>>>>> 0a9065c99c02dc8b063f4a742cc31243c113bc56
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
<<<<<<< HEAD
      case wizard:
        return MaterialPageRoute(builder: (_) => const AuthWizardScreen());
=======
      case widzard:
        return MaterialPageRoute(builder: (_) => const AuthWidzardScreen());
>>>>>>> 0a9065c99c02dc8b063f4a742cc31243c113bc56
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
