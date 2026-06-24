import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/app/router/nav_ext.dart';
import 'package:kunime/core/widgets/toast.dart';
import 'package:kunime/features/splash/application/splash_decision_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(splashDecisionProvider, (prev, next) {
      next.whenData((decision) {
        if (!context.mounted) return;

        if (decision.showRegionWarning) {
          Toast.show(
            context,
            title: 'Region Warning',
            message:
                'Aplikasi ini dioptimalkan untuk region Indonesia. '
                'Beberapa fitur mungkin tidak stabil di region kamu.',
            type: ToastType.warning,
            duration: const Duration(seconds: 4),
          );
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
        ],
      ),
    );
  }
}
