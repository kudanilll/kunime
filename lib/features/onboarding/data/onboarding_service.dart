import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService {
  static const _key = 'has_seen_onboarding';

  Future<bool> hasSeen() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getBool(_key) ?? false;
  }

  Future<void> complete() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setBool(_key, true);
  }
}
