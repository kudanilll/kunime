// lib/app/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:kunime/features/splash/presentation/splash_screen.dart';
import 'package:kunime/screens/home_screen.dart';
import 'package:kunime/screens/profile_screen.dart';
import 'package:kunime/screens/notification_screen.dart';
import 'package:kunime/features/onboarding/presentation/onboarding_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

abstract class RouteName {
  static const splash = 'splash';
  static const home = 'home';
  static const profile = 'profile';
  static const notification = 'notification';
  static const onboarding = 'onboarding';
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: RouteName.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: RouteName.onboarding,
        builder: (_, __) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/home',
        name: RouteName.home,
        builder: (_, __) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'profile',
            name: RouteName.profile,
            builder: (_, __) => const ProfileScreen(),
          ),
          GoRoute(
            path: 'notification',
            name: RouteName.notification,
            builder: (_, __) => const NotificationScreen(),
          ),
        ],
      ),
    ],
  );
});
