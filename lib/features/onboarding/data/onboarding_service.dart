import 'package:kunime/features/onboarding/data/onboarding_repository.dart';
import 'package:kunime/features/onboarding/models/onboarding_page.dart';

class OnboardingService {
  final OnboardingRepository repository;

  OnboardingService(this.repository);

  Future<bool> hasSeen() => repository.hasSeen();
  Future<void> complete() => repository.setSeen();

  List<OnboardingPage> getPages() => repository.getPages();
}
