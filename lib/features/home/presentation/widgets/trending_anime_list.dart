import 'package:flutter/material.dart';
import 'package:kunime/core/widgets/text_button.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';
import 'package:kunime/features/home/presentation/widgets/trending_anime_item.dart';

class TrendingAnimeList extends StatelessWidget {
  final List<UiTrending> items;
  final void Function(UiTrending) onTapItem;
  final VoidCallback? onSeeAll;

  // optional styling
  final String title;
  final EdgeInsetsGeometry headerPadding;

  const TrendingAnimeList({
    super.key,
    required this.items,
    required this.onTapItem,
    this.onSeeAll,
    this.title = 'Trending Minggu Ini',
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
              if (onSeeAll != null)
                KTextButton(
                  label: 'Lihat Selengkapnya',
                  onTap: () => onSeeAll?.call(),
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
            return TrendingAnimeItem(
              imageUrl: a.imageUrl,
              title: a.title,
              episodeCount: a.episodeCount,
              onPressed: () => onTapItem(a),
            );
          },
        ),
      ],
    );
  }
}
