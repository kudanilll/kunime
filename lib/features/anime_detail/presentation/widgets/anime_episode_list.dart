import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/core/widgets/card.dart';
import 'package:kunime/features/anime_detail/models/episode_response_model.dart';

class AnimeEpisodeList extends StatelessWidget {
  final String animeName;
  final String animeImageUrl;
  final AsyncValue<List<EpisodeItem>> episodes;
  final void Function(EpisodeItem episode)? onEpisodeTap;

  const AnimeEpisodeList({
    super.key,
    required this.animeName,
    required this.animeImageUrl,
    required this.episodes,
    this.onEpisodeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Episode',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        episodes.when(
          loading: _buildSkeletonList,
          error: (_, __) => const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Gagal memuat episode',
              style: TextStyle(color: AppColors.neutral400),
            ),
          ),
          data: (items) {
            if (items.isEmpty) return const SizedBox.shrink();

            final sorted = List<EpisodeItem>.from(items)
              ..sort((a, b) => b.episode.compareTo(a.episode));

            return ListView.builder(
              itemCount: sorted.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final episode = sorted[index];
                return KCard(
                  imageUrl: animeImageUrl,
                  title: animeName,
                  episode: '${episode.episode}',
                  imageProportion: KCardImageProportion.square,
                  trailing: KCardTrailing.play,
                  onTap: () => onEpisodeTap?.call(episode),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildSkeletonList() {
    return ListView.builder(
      itemCount: 4,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, __) => const KCardSkeleton(),
    );
  }
}
