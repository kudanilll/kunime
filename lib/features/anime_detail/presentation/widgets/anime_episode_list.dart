import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/core/widgets/card.dart';
import 'package:kunime/features/anime_detail/models/episode_response_model.dart';

class AnimeEpisodeList extends StatelessWidget {
  final String animeImageUrl;
  final List<EpisodeItem> episodes;
  final void Function(EpisodeItem episode)? onEpisodeTap;

  const AnimeEpisodeList({
    super.key,
    required this.animeImageUrl,
    required this.episodes,
    this.onEpisodeTap,
  });

  @override
  Widget build(BuildContext context) {
    if (episodes.isEmpty) return const SizedBox.shrink();

    final sortedEpisodes = List<EpisodeItem>.from(episodes)
      ..sort((a, b) => b.episode.compareTo(a.episode));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Episode',
            style: TextStyle(
              color: AppColors.neutral300,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        ...sortedEpisodes.map(
          (episode) => KCard(
            imageUrl: animeImageUrl,
            title: 'Episode ${episode.episode}',
            imageProportion: KCardImageProportion.square,
            trailing: KCardTrailing.favorite,
            onTap: () => onEpisodeTap?.call(episode),
          ),
        ),
      ],
    );
  }
}
