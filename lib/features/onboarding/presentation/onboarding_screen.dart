import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kunime/app/router/nav_ext.dart';
import 'package:kunime/features/onboarding/presentation/widgets/onboarding_content.dart';
import 'package:kunime/features/onboarding/presentation/widgets/onboarding_indicator.dart';
import 'package:kunime/features/onboarding/providers/onboarding_providers.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  int _index = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final pages = ref.read(onboardingPagesProvider);
    for (final p in pages) {
      precacheImage(CachedNetworkImageProvider(p.image), context);
    }
  }

  Future<void> _next(List pages) async {
    if (_index < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      await ref.read(onboardingServiceProvider).complete();
      if (!mounted) return;
      context.goHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = ref.watch(onboardingPagesProvider);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: pages.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, i) {
              final p = pages[i];
              return OnboardingContent(
                imageUrl: p.image,
                title: p.title,
                subtitle: p.subtitle,
              );
            },
          ),

          Positioned(
            left: 24,
            right: 24,
            bottom: 56,
            child: Column(
              children: [
                OnboardingIndicator(count: pages.length, index: _index),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 36,
                  child: ElevatedButton(
                    onPressed: () => _next(pages),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      _index == pages.length - 1
                          ? 'Mulai Menonton'
                          : 'Selanjutnya',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
