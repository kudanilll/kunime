import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_colors.dart';

class AnimeDetailHeader extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String japaneseTitle;

  const AnimeDetailHeader({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.japaneseTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            errorWidget: (_, __, ___) => Container(
              color: AppColors.neutral800,
              child: const Icon(
                Icons.movie,
                size: 48,
                color: AppColors.neutral600,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppColors.neutral900.withValues(alpha: 0.3),
                  AppColors.neutral900.withValues(alpha: 0.7),
                  AppColors.neutral900,
                ],
                stops: const [0.0, 0.4, 0.7, 1.0],
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.neutral100,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  japaneseTitle,
                  style: const TextStyle(
                    color: AppColors.neutral400,
                    fontSize: 14,
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