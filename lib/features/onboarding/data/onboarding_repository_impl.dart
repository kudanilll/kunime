import 'package:kunime/features/onboarding/data/onboarding_repository.dart';
import 'package:kunime/features/onboarding/models/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  static const _seenKey = 'onboarding_seen';

  @override
  Future<bool> hasSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_seenKey) ?? false;
  }

  @override
  Future<void> setSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_seenKey, true);
  }

  @override
  List<OnboardingPage> getPages() {
    return [
      OnboardingPage(
        image: const String.fromEnvironment('ONBOARDING_URL'),
        title: 'Welcome to Kunime',
        subtitle:
            'Platform nonton anime subtitle Indonesia gratis tanpa iklan judi online.',
      ),
    ];
  }
}
