import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService {
  static const _key = 'has_seen_onboarding';

  Future<bool> hasSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }

  Future<void> complete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
  }
}
