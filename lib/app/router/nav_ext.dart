import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'app_router.dart';

extension AppNav on BuildContext {
  // GO (replace stack)
  void goSplash() => goNamed(RouteName.splash);
  void goHome() => goNamed(RouteName.home);
  void goNotification() => goNamed(RouteName.notification);
  void goOnboarding() => goNamed(RouteName.onboarding);

  // PUSH (keep stack)
  void pushProfile() => pushNamed(RouteName.profile);
  void pushNotification() => pushNamed(RouteName.notification);
  void pushSearch() => pushNamed(RouteName.search);
}
