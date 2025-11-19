import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/features/onboarding/data/onboarding_service.dart';

final onboardingServiceProvider = Provider((_) => OnboardingService());
final hasSeenOnboardingProvider = FutureProvider<bool>((ref) {
  return ref.read(onboardingServiceProvider).hasSeen();
});
