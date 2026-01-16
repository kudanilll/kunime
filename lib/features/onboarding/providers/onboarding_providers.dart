import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/features/onboarding/data/onboarding_repository.dart';
import 'package:kunime/features/onboarding/data/onboarding_repository_impl.dart';
import 'package:kunime/features/onboarding/data/onboarding_service.dart';
import 'package:kunime/features/onboarding/models/onboarding_page.dart';

final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  return OnboardingRepositoryImpl();
});

final onboardingServiceProvider = Provider<OnboardingService>((ref) {
  final repo = ref.watch(onboardingRepositoryProvider);
  return OnboardingService(repo);
});

final onboardingPagesProvider = Provider<List<OnboardingPage>>((ref) {
  return ref.watch(onboardingServiceProvider).getPages();
});
