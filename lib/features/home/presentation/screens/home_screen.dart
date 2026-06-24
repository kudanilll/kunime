import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/core/overlays/blur_overlay.dart';
import 'package:kunime/core/widgets/async_view.dart';
import 'package:kunime/features/home/application/context_menu_controller.dart';
import 'package:kunime/features/home/application/completed_controller.dart';
import 'package:kunime/features/home/application/home_feed_providers.dart';
import 'package:kunime/features/home/application/home_mode_controller.dart';
import 'package:kunime/features/home/presentation/sections/completed/completed_section.dart';
import 'package:kunime/features/home/presentation/sections/favorite/favorite_section.dart';
import 'package:kunime/features/home/presentation/sections/genre/genre_section.dart';
import 'package:kunime/features/home/presentation/sections/ongoing/ongoing_section.dart';
import 'package:kunime/features/home/presentation/widgets/banner_carousel.dart';
import 'package:kunime/features/home/presentation/widgets/banner_skeleton.dart';
import 'package:kunime/features/home/presentation/widgets/category_slider.dart';
import 'package:kunime/features/home/presentation/widgets/home_search_bar.dart';
import 'package:kunime/features/home/presentation/widgets/home_top_bar.dart';
import 'package:kunime/features/home/presentation/sections/ongoing/widgets/ongoing_anime_context_overlay.dart';
import 'package:kunime/features/home/models/home_mode.dart';
import 'package:url_launcher/url_launcher.dart';

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
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final banners = ref.watch(homeBannerProvider);
    final categories = ref.watch(homeCategoryProvider);
    final mode = ref.watch(homeModeProvider);
    final contextMenu = ref.watch(homeContextMenuProvider);

    Future<void> onRefresh() async {
      final futures = <Future<void>>[
        ref.refresh(homeBannerProvider.future).then((_) {}),
      ];

      switch (mode) {
        case HomeMode.ongoing:
          futures.addAll([
            ref.refresh(ongoingAnimeListProvider.future).then((_) {}),
            ref.refresh(homeRecommendationProvider.future).then((_) {}),
          ]);
          break;
        case HomeMode.completed:
          futures.add(ref.read(completedControllerProvider.notifier).refresh());
          break;
        case HomeMode.genre:
          futures.add(ref.refresh(homeGenreProvider.future).then((_) {}));
          break;
        case HomeMode.favorite:
          break;
      }

      await Future.wait(futures);
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
            extendBodyBehindAppBar: true,
            body: RefreshIndicator(
              onRefresh: onRefresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + kToolbarHeight,
                  ),
                  child: Column(
                    children: [
                      // Banner
                      AsyncView(
                        value: banners,
                        loading: BannerSkeleton(),
                        builder: (data) => BannerCarousel(
                          items: data,
                          onTapBanner: (banner) async {
                            final link = banner.deepLink;
                            if (link == null || link.trim().isEmpty) return;
                            final uri = Uri.parse(link);
                            if (!uri.hasScheme ||
                                !(uri.isScheme('http') ||
                                    uri.isScheme('https'))) {
                              return;
                            }
                            if (!await launchUrl(
                              uri,
                              mode: LaunchMode.externalApplication,
                            )) {
                              debugPrint('Could not launch $link');
                            }
                          },
                        ),
                      ),

                      // Search
                      HomeSearchBar(),

                      // Categories
                      CategorySlider(
                        categories: categories,
                        selectedId: modeToCategoryId(mode),
                        onSelected: (category) {
                          final notifier = ref.read(homeModeProvider.notifier);

                          switch (category.id) {
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
                          }
                        },
                      ),

                      // Section
                      _HomeSection(mode: mode),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (contextMenu.visible && contextMenu.item != null) ...[
          BlurOverlay(
            onDismiss: () {
              ref.read(homeContextMenuProvider.notifier).hide();
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

class _HomeSection extends StatelessWidget {
  const _HomeSection({required this.mode});

  final HomeMode mode;

  @override
  Widget build(BuildContext context) {
    switch (mode) {
      case HomeMode.ongoing:
        return const OngoingSection();
      case HomeMode.completed:
        return const CompletedSection();
      case HomeMode.genre:
        return const GenreSection();
      case HomeMode.favorite:
        return const FavoriteSection();
    }
  }
}
