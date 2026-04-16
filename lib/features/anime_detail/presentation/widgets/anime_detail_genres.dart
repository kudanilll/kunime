import 'package:flutter/material.dart';
import 'package:kunime/core/widgets/chip.dart';
import 'package:kunime/core/themes/app_colors.dart';

class AnimeDetailGenres extends StatelessWidget {
  final List<String> genres;

  const AnimeDetailGenres({
    super.key,
    required this.genres,
  });

  @override
  Widget build(BuildContext context) {
    if (genres.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Text(
            'Genre',
            style: TextStyle(
              color: AppColors.neutral300,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: genres
                  .map((genre) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: KChip(label: genre),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}