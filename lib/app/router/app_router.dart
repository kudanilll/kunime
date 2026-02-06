import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kunime/features/home/presentation/screens/home_screen.dart';
import 'package:kunime/features/home/presentation/screens/search_screen.dart';
import 'package:kunime/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:kunime/features/splash/presentation/screens/splash_screen.dart';
import 'package:kunime/features/notification/presentation/screens/notification_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

abstract class RouteName {
  static const splash = 'splash';
  static const home = 'home';
  static const profile = 'profile';
  static const notification = 'notification';
  static const onboarding = 'onboarding';
  static const search = 'search';
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
            path: 'notification',
            name: RouteName.notification,
            builder: (_, __) => const NotificationScreen(),
          ),
          GoRoute(
            path: 'search',
            name: RouteName.search,
            builder: (_, __) => const SearchScreen(),
          ),
        ],
      ),
    ],
  );
});
