import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_tokens.dart';

class BannerSkeleton extends StatefulWidget {
  const BannerSkeleton({super.key});

  @override
  State<BannerSkeleton> createState() => _BannerSkeletonState();
}

class _BannerSkeletonState extends State<BannerSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = AppTokens.secondary.withValues(alpha: 0.6);
    final highlight = AppTokens.secondary.withValues(alpha: 0.9);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment(-1.0 - 2 * _controller.value, 0),
              end: const Alignment(1.0, 0),
              colors: [base, highlight, base],
              stops: const [0.35, 0.5, 0.65],
            ).createShader(rect);
          },
          blendMode: BlendMode.srcATop,
          child: Container(color: base),
        );
      },
    );
  }
}
