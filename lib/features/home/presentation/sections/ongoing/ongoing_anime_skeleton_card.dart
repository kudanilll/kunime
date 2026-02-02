import 'package:flutter/material.dart';

class OngoingAnimeSkeletonCard extends StatelessWidget {
  const OngoingAnimeSkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.grey.shade900,
          child: Stack(
            children: [
              // Image placeholder
              Container(color: Colors.grey.shade900),

              // Text skeleton INSIDE card
              Positioned(
                left: 8,
                right: 8,
                bottom: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _SkeletonLine(width: double.infinity, height: 14),
                    SizedBox(height: 6),
                    _SkeletonLine(width: 70, height: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkeletonLine extends StatelessWidget {
  final double width;
  final double height;

  const _SkeletonLine({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
