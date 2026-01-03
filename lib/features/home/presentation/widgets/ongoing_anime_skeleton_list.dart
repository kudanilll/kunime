import 'package:flutter/material.dart';

import 'ongoing_anime_skeleton_card.dart';

class OngoingAnimeSkeletonList extends StatelessWidget {
  final int itemCount;
  final double height;

  const OngoingAnimeSkeletonList({
    super.key,
    this.itemCount = 6,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: itemCount,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (_, __) => const OngoingAnimeSkeletonCard(),
      ),
    );
  }
}
