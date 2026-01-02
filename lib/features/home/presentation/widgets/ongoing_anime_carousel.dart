import 'package:flutter/material.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';

import 'ongoing_anime_card.dart';

class OngoingAnimeCarousel extends StatelessWidget {
  final List<UiOngoing> items;
  final void Function(UiOngoing) onTapItem;
  final VoidCallback? onSeeAll;

  // Opsional styling
  final String title;
  final EdgeInsetsGeometry headerPadding;
  final EdgeInsetsGeometry listPadding;
  final double itemSpacing;
  final double height;
  final int limit;

  const OngoingAnimeCarousel({
    super.key,
    required this.items,
    required this.onTapItem,
    this.onSeeAll,
    this.title = 'Sedang Berlangsung',
    this.headerPadding = const EdgeInsets.fromLTRB(16, 16, 16, 0),
    this.listPadding = const EdgeInsets.only(top: 12),
    this.itemSpacing = 16,
    this.height = 240,
    this.limit = 8,
  });

  @override
  Widget build(BuildContext context) {
    final data = items.take(limit).toList();
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
              TextButton(
                onPressed: onSeeAll,
                child: const Text('Lihat Selengkapnya'),
              ),
            ],
          ),
        ),

        // List horizontal
        Padding(
          padding: listPadding,
          child: SizedBox(
            height: height,
            child: data.isEmpty
                ? const Center(child: Text('Tidak ada data'))
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(
                      left: itemSpacing,
                      right: itemSpacing,
                    ),
                    itemCount: data.length,
                    separatorBuilder: (_, __) => SizedBox(width: itemSpacing),
                    itemBuilder: (context, index) {
                      final a = data[index];
                      return OngoingAnimeCard(
                        imageUrl: a.image,
                        title: a.title,
                        episode: 'Episode ${a.episode}',
                        updateDay: a.day,
                        onPressed: () => onTapItem(a),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
