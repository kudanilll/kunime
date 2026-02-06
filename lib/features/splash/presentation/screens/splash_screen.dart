import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/app/router/nav_ext.dart';
import 'package:kunime/features/splash/providers/splash_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(splashDecisionProvider, (prev, next) {
      next.whenData((decision) {
        if (!context.mounted) return;

        if (decision.showRegionWarning) {
          // TODO: Show region warning dialog
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //     content: Text(
          //       'This app is optimized for Indonesia. '
          //       'Some features may be unstable in your region.',
          //     ),
          //     duration: Duration(seconds: 4),
          //   ),
          // );
        }
        decision.hasSeenOnboarding ? context.goHome() : context.goOnboarding();
      });
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Transform.translate(
              offset: const Offset(0, -72),
              child: Image.asset(
                'assets/images/ic_launcher.png',
                width: 256,
                height: 256,
              ),
            ),
          ),
          const Positioned(
            bottom: 48,
            left: 0,
            right: 0,
            child: Text(
              'Powered by Nielcode',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
