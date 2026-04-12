import 'package:flutter/material.dart';
import 'package:kunime/core/widgets/card.dart';

class CompletedSkeletonList extends StatelessWidget {
  const CompletedSkeletonList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, __) => const KCardSkeleton(),
    );
  }
}
