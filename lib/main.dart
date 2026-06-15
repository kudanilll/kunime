import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/app/router/app_router.dart';
import 'package:kunime/core/themes/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Handle errors caught by the Flutter framework
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kReleaseMode) {
      // TODO: send to crash reporting service (e.g., Sentry, Firebase Crashlytics)
      debugPrint('FlutterError: ${details.exceptionAsString()}');
    }
  };

  // Handle async errors not caught by Flutter (replaces runZonedGuarded since Flutter 3.3)
  PlatformDispatcher.instance.onError = (error, stack) {
    if (kReleaseMode) {
      // TODO: send to crash reporting service
      debugPrint('Uncaught async error: $error\n$stack');
    }
    return true;
  };

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    });
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Kunime',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      scrollBehavior: const MaterialScrollBehavior().copyWith(scrollbars: true),
      routerConfig: router,
    );
  }
}
