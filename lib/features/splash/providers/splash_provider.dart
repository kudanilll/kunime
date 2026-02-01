import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/features/onboarding/providers/onboarding_provider.dart';
import 'package:kunime/features/splash/data/region_service.dart';

class SplashDecision {
  final bool hasSeenOnboarding;
  final bool showRegionWarning;

  const SplashDecision({
    required this.hasSeenOnboarding,
    required this.showRegionWarning,
  });
}

final regionServiceProvider = Provider<RegionService>((_) {
  return RegionService();
});

final splashDecisionProvider = FutureProvider<SplashDecision>((ref) async {
  final onboarding = ref.read(onboardingServiceProvider);
  final region = ref.read(regionServiceProvider);

  final results = await Future.wait([
    onboarding.hasSeen(),
    region.detectCountryCode().timeout(
      const Duration(seconds: 2),
      onTimeout: () => null,
    ),
    Future.delayed(const Duration(seconds: 3)),
  ]);

  final hasSeen = results[0] as bool;
  final countryCode = results[1] is String ? results[1] as String : null;
  final isIndonesiaUser = countryCode == 'ID';

  return SplashDecision(
    hasSeenOnboarding: hasSeen,
    showRegionWarning: !isIndonesiaUser,
  );
});
