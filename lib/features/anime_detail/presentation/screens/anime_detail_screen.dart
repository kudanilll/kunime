import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/core/themes/app_tokens.dart';
import 'package:kunime/features/anime_detail/application/anime_detail_providers.dart';
import 'package:kunime/features/anime_detail/presentation/widgets/anime_detail_header.dart';
import 'package:kunime/features/anime_detail/presentation/widgets/anime_detail_info.dart';
import 'package:kunime/features/anime_detail/presentation/widgets/anime_detail_meta.dart';
import 'package:kunime/features/anime_detail/presentation/widgets/anime_detail_genres.dart';
import 'package:kunime/features/anime_detail/presentation/widgets/anime_detail_description.dart';
import 'package:kunime/features/anime_detail/presentation/widgets/anime_episode_list.dart';

class AnimeDetailScreen extends ConsumerWidget {
  final String endpoint;

  const AnimeDetailScreen({super.key, required this.endpoint});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(animeDetailProvider(endpoint));
    final episodesAsync = ref.watch(animeEpisodesProvider(endpoint));

    return Scaffold(
      backgroundColor: AppTokens.background,
      body: detailAsync.when(
        data: (detail) => CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimeDetailHeader(
                    imageUrl: detail.image,
                    title: detail.title,
                    japaneseTitle: detail.japaneseTitle,
                  ),
                  AnimeDetailInfo(
                    score: detail.score,
                    type: detail.type,
                    status: detail.status,
                    totalEpisode: detail.totalEpisode,
                    duration: detail.duration,
                    releaseDate: detail.releaseDate,
                  ),
                  AnimeDetailMeta(
                    studio: detail.studio,
                    producers: detail.producers,
                  ),
                  AnimeDetailGenres(genres: detail.genres),
                  AnimeDetailDescription(synopsis: detail.synopsis),
                ],
              ),
            ),
            episodesAsync.when(
              data: (episodes) => SliverToBoxAdapter(
                child: AnimeEpisodeList(
                  episodes: episodes.episodes,
                  onEpisodeTap: (episode) {
                    ref
                        .read(watchEventProvider.notifier)
                        .recordWatch(endpoint, episode.episode);
                  },
                ),
              ),
              loading: () => const SliverToBoxAdapter(
                child: SizedBox(
                  height: 200,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.purple400,
                    ),
                  ),
                ),
              ),
              error: (_, __) =>
                  const SliverToBoxAdapter(child: SizedBox.shrink()),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.purple400),
        ),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 48,
                color: AppColors.neutral500,
              ),
              const SizedBox(height: 16),
              Text(
                'Gagal memuat detail anime',
                style: const TextStyle(
                  color: AppColors.neutral400,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => ref.refresh(animeDetailProvider(endpoint)),
                child: const Text(
                  'Coba Lagi',
                  style: TextStyle(color: AppColors.purple400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
