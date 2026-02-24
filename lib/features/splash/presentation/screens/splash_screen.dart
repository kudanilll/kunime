import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/app/router/nav_ext.dart';
import 'package:kunime/core/overlays/dialog_overlay.dart';
import 'package:kunime/features/splash/providers/splash_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(splashDecisionProvider, (prev, next) {
      next.whenData((decision) async {
        if (!context.mounted) return;
        if (decision.showRegionWarning) {
          _showDialog(context);
          if (!context.mounted) return;
        }
        decision.hasSeenOnboarding ? context.goHome() : context.goOnboarding();
      });
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Transform.translate(
              offset: const Offset(0, -72),
              child: Image.asset(
                'assets/images/ic_launcher.png',
                width: 256,
                height: 256,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context) {
    DialogOverlay.show(
      context,
      title: 'Region Notice',
      message:
          'This app is optimized for Indonesia, Some features may be unstable in your region',
      actions: [
        DialogAction(
          label: 'Cancel',
          style: DialogActionStyle.primary,
          onTap: () {},
        ),
        DialogAction(
          label: 'Understand',
          style: DialogActionStyle.destructive,
          onTap: () {},
        ),
      ],
    );
  }
}
