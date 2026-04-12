import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/features/onboarding/application/onboarding_providers.dart';
import 'package:kunime/features/splash/data/region_service.dart';

class SplashDecision {
  const SplashDecision({
    required this.hasSeenOnboarding,
    required this.showRegionWarning,
  });

  final bool hasSeenOnboarding;
  final bool showRegionWarning;
}

final regionServiceProvider = Provider<RegionService>((ref) {
  return RegionService();
});

final splashDecisionProvider = FutureProvider<SplashDecision>((ref) async {
  final onboardingRepository = ref.read(onboardingRepositoryProvider);
  final regionService = ref.read(regionServiceProvider);

  final results = await Future.wait([
    onboardingRepository.hasSeen(),
    regionService.detectCountryCode().timeout(
      const Duration(seconds: 2),
      onTimeout: () => null,
    ),
    Future.delayed(const Duration(seconds: 3)),
  ]);

  final hasSeen = results[0] as bool;
  final countryCode = results[1] is String ? results[1] as String : null;

  return SplashDecision(
    hasSeenOnboarding: hasSeen,
    showRegionWarning: countryCode != 'ID',
  );
});
