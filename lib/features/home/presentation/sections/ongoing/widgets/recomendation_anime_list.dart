import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/core/widgets/card.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';

class RecommendationAnimeList extends StatelessWidget {
  final AsyncValue<List<UiRecommendation>> value;
  final void Function(UiRecommendation) onTapItem;

  final String title;
  final EdgeInsetsGeometry headerPadding;

  const RecommendationAnimeList({
    super.key,
    required this.value,
    required this.onTapItem,
    this.title = 'Rekomendasi',
    this.headerPadding = const EdgeInsets.fromLTRB(16, 10, 16, 4),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Header
        Padding(
          padding: headerPadding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),

        value.when(
          loading: () => _buildSkeletonList(),
          error: (_, __) => const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Gagal memuat rekomendasi',
              style: TextStyle(color: AppColors.neutral400),
            ),
          ),
          data: (items) {
            if (items.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Tidak ada rekomendasi',
                  style: TextStyle(color: AppColors.neutral400),
                ),
              );
            }

            return ListView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final a = items[index];
                return KCard(
                  imageUrl: a.image,
                  title: a.title,
                  rating: a.score.toString(),
                  trailing: KCardTrailing.none,
                  onTap: () => onTapItem(a),
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
      itemCount: 6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, __) => const KCardSkeleton(),
    );
  }
}
