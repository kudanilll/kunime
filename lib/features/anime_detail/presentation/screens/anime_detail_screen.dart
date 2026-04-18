import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/core/themes/app_tokens.dart';
import 'package:kunime/features/anime_detail/application/anime_detail_providers.dart';
import 'package:kunime/features/anime_detail/presentation/widgets/anime_detail_header.dart';
import 'package:kunime/features/anime_detail/presentation/widgets/anime_detail_info.dart';
import 'package:kunime/features/anime_detail/presentation/widgets/anime_detail_description.dart';
import 'package:kunime/features/anime_detail/presentation/widgets/anime_episode_list.dart';

class AnimeDetailScreen extends ConsumerStatefulWidget {
  final String endpoint;

  const AnimeDetailScreen({super.key, required this.endpoint});

  @override
  ConsumerState<AnimeDetailScreen> createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends ConsumerState<AnimeDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  double _appBarOpacity = 0.0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final opacity = (_scrollController.offset / 80).clamp(0.0, 1.0);
      if (opacity != _appBarOpacity) {
        setState(() => _appBarOpacity = opacity);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(animeDetailProvider(widget.endpoint));
    final episodesAsync = ref.watch(animeEpisodesProvider(widget.endpoint));
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        flexibleSpace: AnimatedOpacity(
          opacity: _appBarOpacity,
          duration: Duration.zero,
          curve: Curves.easeInOut,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTokens.background,
                  AppTokens.background.withValues(alpha: 0.9),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.7, 1.0],
              ),
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: _AppBarButton(
            showBackground: _appBarOpacity < 0.5,
            child: const BackButtonIcon(),
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      backgroundColor: AppTokens.background,
      body: detailAsync.when(
        data: (detail) => CustomScrollView(
          shrinkWrap: true,
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimeDetailHeader(
                    imageUrl: detail.image,
                    title: detail.title,
                  ),
                  AnimeDetailInfo(
                    score: detail.score,
                    type: detail.type,
                    status: detail.status,
                    genres: detail.genres,
                  ),
                  const SizedBox(height: 16),
                  AnimeDetailDescription(
                    releaseDate: detail.releaseDate,
                    synopsis: detail.synopsis,
                    studio: detail.studio,
                    producers: detail.producers,
                  ),
                ],
              ),
            ),
            episodesAsync.when(
              data: (episodes) => SliverToBoxAdapter(
                child: AnimeEpisodeList(
                  animeName: detail.title,
                  animeImageUrl: detail.image,
                  episodes: episodesAsync.whenData((e) => e.episodes),
                  onEpisodeTap: (episode) {
                    ref
                        .read(watchEventProvider.notifier)
                        .recordWatch(widget.endpoint, episode.episode);
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
            SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.of(context).padding.bottom),
            ),
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
              const Text(
                'Gagal memuat detail anime',
                style: TextStyle(color: AppColors.neutral400, fontSize: 14),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () =>
                    ref.refresh(animeDetailProvider(widget.endpoint)),
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

class _AppBarButton extends StatelessWidget {
  const _AppBarButton({
    required this.showBackground,
    required this.child,
    required this.onTap,
  });

  final bool showBackground;
  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: showBackground
              ? AppTokens.background.withValues(alpha: 0.5)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: IconTheme(
            data: const IconThemeData(color: AppColors.white, size: 20),
            child: child,
          ),
        ),
      ),
    );
  }
}
