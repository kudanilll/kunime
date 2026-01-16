import 'package:kunime/features/onboarding/models/onboarding_page.dart';

abstract class OnboardingRepository {
  // state
  Future<bool> hasSeen();
  Future<void> setSeen();

  // content
  List<OnboardingPage> getPages();
}
