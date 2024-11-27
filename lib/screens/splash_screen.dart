import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
<<<<<<< HEAD
import 'package:get/get.dart';
import 'package:kunime/screens/auth/auth_wizard.dart';
=======
import 'package:kunime/routes.dart';
>>>>>>> 0a9065c99c02dc8b063f4a742cc31243c113bc56
import 'package:kunime/utils/theme_data.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
<<<<<<< HEAD

=======
>>>>>>> 0a9065c99c02dc8b063f4a742cc31243c113bc56
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    Future.delayed(const Duration(seconds: 3), () {
      Get.to(const AuthWizardScreen());
    });
=======
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) Navigator.pushReplacementNamed(context, Routes.widzard);
>>>>>>> 0a9065c99c02dc8b063f4a742cc31243c113bc56
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.transparent,
          // statusBarColor: Theme.of(context).colorScheme.background,
          // Status bar brightness (optional)
          statusBarIconBrightness: isLightMode(context)
              ? Brightness.light
              : Brightness.dark, // For Android (dark icons)
          statusBarBrightness: isLightMode(context)
              ? Brightness.dark
              : Brightness.light, // For iOS (dark icons)
        ),
      ),
      body: Center(
        child: Image.asset(
          'assets/images/ic_launcher.png',
          width: 128,
          height: 128,
        ),
      ),
    );
  }
}
