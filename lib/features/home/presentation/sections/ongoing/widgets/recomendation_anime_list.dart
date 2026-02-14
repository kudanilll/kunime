import 'package:flutter/material.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';
import 'package:kunime/features/home/presentation/sections/ongoing/widgets/recomendation_anime_item.dart';

class RecommendationAnimeList extends StatelessWidget {
  final List<UiRecommendation> items;
  final void Function(UiRecommendation) onTapItem;

  // optional styling
  final String title;
  final EdgeInsetsGeometry headerPadding;

  const RecommendationAnimeList({
    super.key,
    required this.items,
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

        ListView.builder(
          itemCount: items.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final a = items[index];
            return RecommendationAnimeItem(
              imageUrl: a.image,
              title: a.title,
              onPressed: () => onTapItem(a),
            );
          },
        ),
      ],
    );
  }
}
