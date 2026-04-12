import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/features/onboarding/data/repositories/shared_preferences_onboarding_repository.dart';
import 'package:kunime/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:kunime/features/onboarding/models/onboarding_page.dart';

final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  return SharedPreferencesOnboardingRepository();
});

final onboardingPagesProvider = Provider<List<OnboardingPage>>((ref) {
  return ref.watch(onboardingRepositoryProvider).getPages();
});
