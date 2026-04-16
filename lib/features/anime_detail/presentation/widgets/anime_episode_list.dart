import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/core/themes/app_tokens.dart';
import 'package:kunime/features/anime_detail/models/episode_response_model.dart';

class AnimeEpisodeList extends StatelessWidget {
  final List<EpisodeItem> episodes;
  final void Function(EpisodeItem episode)? onEpisodeTap;

  const AnimeEpisodeList({
    super.key,
    required this.episodes,
    this.onEpisodeTap,
  });

  @override
  Widget build(BuildContext context) {
    if (episodes.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Episode',
                style: TextStyle(
                  color: AppColors.neutral300,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (episodes.length > 10)
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Lihat Semua',
                    style: TextStyle(
                      color: AppColors.purple300,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: episodes.length > 10 ? 10 : episodes.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final episode = episodes[index];
                return GestureDetector(
                  onTap: () => onEpisodeTap?.call(episode),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppTokens.secondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${episode.episode}',
                      style: const TextStyle(
                        color: AppColors.neutral200,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}