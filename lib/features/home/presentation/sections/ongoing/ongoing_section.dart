import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/features/home/presentation/sections/ongoing/widgets/ongoing_anime_carousel.dart';
import 'package:kunime/features/home/presentation/sections/ongoing/widgets/recomendation_anime_list.dart';
import 'package:kunime/features/home/providers/home_provider.dart';

class OngoingSection extends ConsumerWidget {
  const OngoingSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ongoing = ref.watch(ongoingAnimeProvider);
    final recommendation = ref.watch(recommendationProvider);
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
