import 'package:kunime/features/onboarding/models/onboarding_page.dart';

abstract class OnboardingRepository {
  Future<bool> hasSeen();
  Future<void> setSeen();
  List<OnboardingPage> getPages();
}
