import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/features/home/application/home_feed_providers.dart';
import 'package:kunime/features/home/presentation/sections/ongoing/widgets/ongoing_anime_carousel.dart';
import 'package:kunime/features/home/presentation/sections/ongoing/widgets/recommendation_anime_list.dart';

class OngoingSection extends ConsumerWidget {
  const OngoingSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ongoing = ref.watch(ongoingAnimeListProvider);
    final recommendation = ref.watch(homeRecommendationProvider);
    return Column(
      children: [
        OngoingAnimeCarousel(
          value: ongoing,
          onTapItem: (_) {},
          onSeeAll: () {},
        ),
        const SizedBox(height: 10),
        RecommendationAnimeList(
          value: recommendation,
          onTapItem: (_) {
            // TODO: Navigate to anime detail
          },
        ),
      ],
    );
  }
}
