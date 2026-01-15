import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/features/onboarding/data/onboarding_service.dart';
import 'package:kunime/features/onboarding/models/onboarding_page.dart';

final onboardingServiceProvider = Provider<OnboardingService>((ref) {
  return OnboardingService();
});

List<OnboardingPage> _readOnboardingPagesFromEnv() {
  final e = dotenv.env;

  String must(String key) {
    final v = e[key];
    if (v == null || v.trim().isEmpty || v == 'null') {
      throw Exception('Missing onboarding env: $key');
    }
    return v.trim();
  }

  return [
    OnboardingPage(
      image: must('ONBOARDING_1_URL'),
      title: 'Kunime',
      subtitle: 'Nonton anime dengan subtitle Indonesia',
    ),
    OnboardingPage(
      image: must('ONBOARDING_2_URL'),
      title: 'Cepat & Ringan',
      subtitle: 'Optimasi untuk pengalaman mobile yang lancar',
    ),
    OnboardingPage(
      image: must('ONBOARDING_3_URL'),
      title: 'Sederhana & Terfokus',
      subtitle: 'Hanya anime. Tanpa gangguan.',
    ),
  ];
}

final onboardingPagesProvider = Provider<List<OnboardingPage>>((ref) {
  return _readOnboardingPagesFromEnv();
});
