import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/core/widgets/async_view.dart';
import 'package:kunime/features/home/presentation/widgets/banner_carousel.dart';
import 'package:kunime/features/home/presentation/widgets/category_slider.dart';
import 'package:kunime/features/home/presentation/widgets/home_search_bar.dart';
import 'package:kunime/features/home/presentation/widgets/home_top_bar.dart';
import 'package:kunime/features/home/presentation/widgets/ongoing_anime_carousel.dart';
import 'package:kunime/features/home/presentation/widgets/ongoing_anime_context_overlay.dart';
import 'package:kunime/features/home/presentation/widgets/trending_anime_list.dart';
import 'package:kunime/features/home/providers/context_menu_provider.dart';
import 'package:kunime/features/home/providers/home_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final banners = ref.watch(bannerListProvider);
    final ongoing = ref.watch(ongoingAnimeProvider);
    final trending = ref.watch(trendingAnimeProvider);
    final categories = ref.watch(categoriesProvider);
    final selectedId = ref.watch(selectedCategoryIdProvider);
    final contextMenu = ref.watch(contextMenuProvider);

    Future<void> onRefresh() async {
      ref.invalidate(bannerListProvider);
      ref.invalidate(ongoingAnimeProvider);
      ref.invalidate(trendingAnimeProvider);
      ref.invalidate(categoriesProvider);
      await Future<void>.delayed(const Duration(milliseconds: 250));
    }

    return Scaffold(
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
                  AsyncView(
                    value: categories,
                    builder: (cats) {
                      // Initialize selectedId if null
                      final sel =
                          selectedId ??
                          (cats.isNotEmpty ? cats.first.id : null);
                      if (selectedId == null && sel != null) {
                        // Set selectedId once without triggering build loop
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ref.read(selectedCategoryIdProvider.notifier).state =
                              sel;
                        });
                      }
                      return CategorySlider(
                        categories: cats,
                        selectedId: sel,
                        onSelected: (c) {
                          ref.read(selectedCategoryIdProvider.notifier).state =
                              c.id;
                          // TODO: trigger fetch/filter section berdasarkan c.id
                        },
                      );
                    },
                  ),

                  // Ongoing
                  OngoingAnimeCarousel(
                    onTapItem: (a) => {},
                    onSeeAll: () => {},
                    value: ongoing,
                  ),

                  SizedBox(height: 10),

                  // Trending
                  AsyncView(
                    value: trending,
                    builder: (items) => TrendingAnimeList(
                      items: items,
                      onTapItem: (a) => {},
                      onSeeAll: () => {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (contextMenu.isVisible) ...[
            // Touch catcher (background freeze)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  ref.read(contextMenuProvider.notifier).hide();
                },
                child: Container(color: Colors.black.withValues(alpha: 0.0)),
              ),
            ),

            // Floating card
            OngoingAnimeContextOverlay(
              item: contextMenu.item!,
              link: contextMenu.link!,
            ),
          ],
        ],
      ),
    );
  }
}
