import 'package:flutter/material.dart';
import 'package:kunime/core/widgets/card.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';

class CompletedAnimeList extends StatelessWidget {
  const CompletedAnimeList({
    super.key,
    required this.items,
    required this.onTapItem,
  });

  final List<UiCompleted> items;
  final ValueChanged<UiCompleted> onTapItem;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final anime = items[index];
        return KCard(
          imageUrl: anime.image,
          title: anime.title,
          episode: anime.totalEpisode.toString(),
          rating: anime.score.toString(),
          trailing: KCardTrailing.none,
          onTap: () => onTapItem(anime),
        );
      },
    );
  }
}
