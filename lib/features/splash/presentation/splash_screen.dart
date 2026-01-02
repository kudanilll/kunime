import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/app/router/nav_ext.dart';
import 'package:kunime/features/onboarding/presentation/onboarding_providers.dart';
import 'package:kunime/utils/theme_data.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _boot();
  }

  Future<void> _boot() async {
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
    hasSeen ? context.goHome() : context.goOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    final light = isLightMode(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: light ? Brightness.light : Brightness.dark,
          statusBarBrightness: light ? Brightness.dark : Brightness.light,
        ),
      ),
      body: const Center(
        child: Image(
          image: AssetImage('assets/images/ic_launcher.png'),
          width: 128,
          height: 128,
        ),
      ),
    );
  }
}
