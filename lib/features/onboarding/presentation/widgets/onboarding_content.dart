import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kunime/core/themes/app_colors.dart';

class OnboardingContent extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  const OnboardingContent({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),

        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.black.withValues(alpha: 0.7),
          ),
        ),

        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black54, Colors.black],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 160),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColors.neutral400,
                  ),
                ),
              ],
            ),
          ),
        ),

        const Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 160),
            child: Image(
              image: AssetImage('assets/images/ic_launcher.png'),
              width: 196,
            ),
          ),
        ),
      ],
    );
  }
}
