import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/app/router/nav_ext.dart';
import 'package:kunime/features/onboarding/presentation/onboarding_providers.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  Future<void> _boot(BuildContext context) async {
    // Prepare async tasks
    final seenFuture = ref.read(onboardingServiceProvider).hasSeen();

    // Check onboarding status after 3 seconds
    final results = await Future.wait([
      Future.delayed(const Duration(seconds: 3)),
      seenFuture,
    ]);

    final hasSeen = results[1] as bool;
    if (!mounted) return;

    // Navigate to onboarding or home screen
    hasSeen ? AppNav(context).goHome() : AppNav(context).goOnboarding();
  }

  @override
  void initState() {
    super.initState();
    _boot(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Image(
              image: AssetImage('assets/images/ic_launcher.png'),
              width: 256,
              height: 256,
            ),
          ),
          Positioned(
            bottom: 48,
            left: 0,
            right: 0,
            child: Text(
              'Powered by Nielcode',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
