import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/core/overlays/blur_overlay.dart';
import 'package:kunime/core/widgets/async_view.dart';
import 'package:kunime/features/home/presentation/sections/completed/completed_section.dart';
import 'package:kunime/features/home/presentation/sections/favorite/favorite_section.dart';
import 'package:kunime/features/home/presentation/sections/genre/genre_section.dart';
import 'package:kunime/features/home/presentation/sections/history/history_section.dart';
import 'package:kunime/features/home/presentation/sections/ongoing/ongoing_section.dart';
import 'package:kunime/features/home/presentation/widgets/banner_carousel.dart';
import 'package:kunime/features/home/presentation/widgets/category_slider.dart';
import 'package:kunime/features/home/presentation/widgets/home_search_bar.dart';
import 'package:kunime/features/home/presentation/widgets/home_top_bar.dart';
import 'package:kunime/features/home/presentation/sections/ongoing/widgets/ongoing_anime_context_overlay.dart';
import 'package:kunime/features/home/providers/context_menu_provider.dart';
import 'package:kunime/features/home/providers/home_provider.dart';
import 'package:kunime/features/home/providers/home_state_provider.dart';
import 'package:kunime/features/home/models/home_mode.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String modeToCategoryId(HomeMode mode) {
    switch (mode) {
      case HomeMode.ongoing:
        return 'ongoing';
      case HomeMode.completed:
        return 'completed';
      case HomeMode.genre:
        return 'genre';
      case HomeMode.favorite:
        return 'favorite';
      case HomeMode.history:
        return 'history';
    }
  }

  Widget _buildSection(HomeMode mode) {
    switch (mode) {
      case HomeMode.ongoing:
        return const OngoingSection();
      case HomeMode.completed:
        return const CompletedSection();
      case HomeMode.genre:
        return const GenreSection();
      case HomeMode.favorite:
        return const FavoriteSection();
      case HomeMode.history:
        return const HistorySection();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final banners = ref.watch(bannerListProvider);
    final categories = ref.watch(categoriesProvider);
    final homeState = ref.watch(homeStateProvider);
    final mode = homeState.mode;
    final contextMenu = ref.watch(contextMenuProvider);

    Future<void> onRefresh() async {
      ref.invalidate(bannerListProvider);
      ref.invalidate(ongoingAnimeProvider);
      ref.invalidate(trendingAnimeProvider);
      ref.invalidate(categoriesProvider);
      await Future<void>.delayed(const Duration(milliseconds: 250));
    }

    return Stack(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: const HomeTopBar(),
            body: Stack(
              children: [
                RefreshIndicator(
                  onRefresh: onRefresh,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        // Banner
                        AsyncView(
                          value: banners,
                          builder: (data) =>
                              BannerCarousel(items: data, onTapBanner: (b) {}),
                        ),

                        // Search
                        HomeSearchBar(),

                        // Categories
                        // Categories
                        AsyncView(
                          value: categories,
                          builder: (cats) {
                            final selectedId = modeToCategoryId(mode);

                            return CategorySlider(
                              categories: cats,
                              selectedId: selectedId,
                              onSelected: (c) {
                                final notifier = ref.read(
                                  homeStateProvider.notifier,
                                );

                                switch (c.id) {
                                  case 'ongoing':
                                    notifier.setMode(HomeMode.ongoing);
                                    break;
                                  case 'completed':
                                    notifier.setMode(HomeMode.completed);
                                    break;
                                  case 'genre':
                                    notifier.setMode(HomeMode.genre);
                                    break;
                                  case 'favorite':
                                    notifier.setMode(HomeMode.favorite);
                                    break;
                                  case 'history':
                                    notifier.setMode(HomeMode.history);
                                    break;
                                }
                              },
                            );
                          },
                        ),

                        // Section
                        _buildSection(mode),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (contextMenu.visible && contextMenu.item != null) ...[
          BlurOverlay(
            onDismiss: () {
              ref.read(contextMenuProvider.notifier).hide();
            },
            child: OngoingAnimeContextOverlay(
              item: contextMenu.item!,
              link: contextMenu.link!,
            ),
          ),
        ],
      ],
    );
  }
}
