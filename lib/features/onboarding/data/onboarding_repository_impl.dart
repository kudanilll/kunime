import 'package:flutter_dotenv/flutter_dotenv.dart';
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
}
