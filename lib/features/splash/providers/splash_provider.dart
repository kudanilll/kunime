import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/features/onboarding/providers/onboarding_provider.dart';

final splashDecisionProvider = FutureProvider<bool>((ref) async {
  final onboarding = ref.read(onboardingServiceProvider);
  final hasSeen = await onboarding.hasSeen();

  await Future.delayed(const Duration(seconds: 3));

  return hasSeen;
});
