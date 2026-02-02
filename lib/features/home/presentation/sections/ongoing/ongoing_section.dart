import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/core/widgets/async_view.dart';
import 'package:kunime/features/home/presentation/sections/ongoing/widgets/ongoing_anime_carousel.dart';
import 'package:kunime/features/home/presentation/sections/ongoing/widgets/trending_anime_list.dart';
import 'package:kunime/features/home/providers/home_provider.dart';

class OngoingSection extends ConsumerWidget {
  const OngoingSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ongoing = ref.watch(ongoingAnimeProvider);
    final trending = ref.watch(trendingAnimeProvider);

    return Column(
      children: [
        OngoingAnimeCarousel(
          value: ongoing,
          onTapItem: (_) {},
          onSeeAll: () {},
        ),
        const SizedBox(height: 10),
        AsyncView(
          value: trending,
          builder: (items) => TrendingAnimeList(
            items: items,
            onTapItem: (_) {},
            onSeeAll: () {},
          ),
        ),
      ],
    );
  }
}
