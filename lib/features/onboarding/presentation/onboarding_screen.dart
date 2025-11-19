import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/app/router/nav_ext.dart';
import 'package:kunime/features/onboarding/presentation/onboarding_providers.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await ref.read(onboardingServiceProvider).complete();
            if (!context.mounted) return;
            context.goHome();
          },
          child: const Text('Mulai'),
        ),
      ),
    );
  }
}
