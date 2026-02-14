import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/core/widgets/async_view.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';
import 'package:kunime/features/home/presentation/sections/ongoing/widgets/recomendation_anime_card.dart';

class RecommendationAnimeList extends StatelessWidget {
  final AsyncValue<List<UiRecommendation>> value;
  final void Function(UiRecommendation) onTapItem;

  // optional styling
  final String title;
  final EdgeInsetsGeometry headerPadding;

  const RecommendationAnimeList({
    super.key,
    required this.value,
    required this.onTapItem,
    this.title = 'Rekomendasi',
    this.headerPadding = const EdgeInsets.fromLTRB(16, 10, 16, 14),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: headerPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        AsyncView(
          value: value,
          builder: (items) {
            if (items.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Tidak ada rekomendasi',
                    style: TextStyle(color: AppColors.neutral400),
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final a = items[index];
                return RecommendationAnimeCard(
                  image: a.image,
                  title: a.title,
                  rating: a.score.toString(),
                  onPressed: () => onTapItem(a),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
