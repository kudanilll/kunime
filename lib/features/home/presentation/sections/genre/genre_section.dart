import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/features/home/providers/genre_provider.dart';
import 'widgets/genre_grid.dart';

class GenreSection extends ConsumerWidget {
  const GenreSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genres = ref.watch(uiGenreProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: genres.when(
        loading: () => const _GenreSkeletonGrid(),
        error: (_, __) => const SizedBox.shrink(),
        data: (items) => GenreGrid(genres: items),
      ),
    );
  }
}

class _GenreSkeletonGrid extends StatelessWidget {
  const _GenreSkeletonGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.6,
      ),
      itemBuilder: (_, __) => const GenreCardSkeleton(),
    );
  }
}

class GenreCardSkeleton extends StatelessWidget {
  const GenreCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral800,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
