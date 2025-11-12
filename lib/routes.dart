import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kunime/screens/home_screen.dart';
import 'package:kunime/screens/notification_screen.dart';
import 'package:kunime/screens/profile_screen.dart';
import 'package:kunime/screens/splash_screen.dart';

class Routes {
  // Initial route
  static const String initialRoute = '/';

  // Route constants
  static const String splash = '/';
  static const String home = '/home';
  static const String profile = '/home/profile';
  static const String notification = '/home/notification';

  // Pages mapping (reduce duplication by using a map of route names to pages)
  static final Map<String, Widget Function()> _pagesMap = {
    splash: () => const SplashScreen(),
    home: () => const HomeScreen(),
    profile: () => const ProfileScreen(),
    notification: () => const NotificationScreen(),
  };

  // GetPage list for GetX routing
  static List<GetPage> get pages {
    return _pagesMap.entries.map((entry) {
      return GetPage(name: entry.key, page: entry.value);
    }).toList();
  }

  // Navigate to a route using GetX
  static navigateTo(String route) {
    final pageBuilder = _pagesMap[route];
    if (pageBuilder != null) {
      return Get.to(pageBuilder());
    }
  }

  // Replace to a route using GetX
  static replaceTo(String route) {
    final pageBuilder = _pagesMap[route];
    if (pageBuilder != null) {
      return Get.off(pageBuilder());
    }
  }

  @Deprecated('better use GetX to navigate')
  // Generate route using MaterialPageRoute
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final pageBuilder = _pagesMap[settings.name];
    if (pageBuilder != null) {
      return MaterialPageRoute(builder: (_) => pageBuilder());
    }
    // Fallback route if the route doesn't exist
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text('Route tidak ditemukan: ${settings.name}')),
      ),
    );
  }
}
