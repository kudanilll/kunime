import 'dart:ui';
import 'package:flutter/material.dart';

class BlurOverlay extends StatelessWidget {
  // Content overlay (dialog, context menu panel, etc.)
  final Widget child;
  final VoidCallback? onDismiss;
  final bool enableBlur;
  final double blurSigma;
  final double scrimOpacity;
  final Duration duration;

  const BlurOverlay({
    super.key,
    required this.child,
    this.onDismiss,
    this.enableBlur = true,
    this.blurSigma = 4,
    this.scrimOpacity = 0.25,
    this.duration = const Duration(milliseconds: 180),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background blur + scrim + tap to dismiss
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onDismiss,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: duration,
            curve: Curves.easeOutCubic,
            builder: (context, t, _) {
              final sigma = enableBlur ? blurSigma * t : 0.0;

              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
                child: Container(
                  color: Colors.black.withValues(alpha: scrimOpacity * t),
                ),
              );
            },
          ),
        ),
        // Foreground content
        child,
      ],
    );
  }
}
