import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';
import 'package:kunime/features/home/presentation/widgets/ongoing_anime_skeleton_list.dart';

import 'ongoing_anime_card.dart';

class OngoingAnimeCarousel extends StatelessWidget {
  final AsyncValue<List<UiOngoing>> value;
  final void Function(UiOngoing) onTapItem;
  final VoidCallback? onSeeAll;

  final String title;
  final double height;
  final int limit;

  const OngoingAnimeCarousel({
    super.key,
    required this.value,
    required this.onTapItem,
    this.onSeeAll,
    this.title = 'Sedang Berlangsung',
    this.height = 200,
    this.limit = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: onSeeAll,
                child: const Text('Lihat Selengkapnya'),
              ),
            ],
          ),
        ),

        // Content
        value.when(
          loading: () => const OngoingAnimeSkeletonList(),
          error: (e, _) => Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Gagal memuat data'),
          ),
          data: (items) {
            final data = items.take(limit).toList();

            if (data.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Tidak ada data'),
              );
            }

            return SizedBox(
              height: height,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: data.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final a = data[index];
                  return OngoingAnimeCard(
                    imageUrl: a.image,
                    title: a.title,
                    episode: 'Episode ${a.episode}',
                    updateDay: a.day,
                    onPressed: () => onTapItem(a),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
