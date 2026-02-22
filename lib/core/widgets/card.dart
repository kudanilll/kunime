import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/core/themes/app_tokens.dart';
import 'package:kunime/core/widgets/chip.dart';
import 'package:kunime/core/widgets/svg_icon.dart';

enum KCardImageProportion { square, vertical }

enum KCardTrailing { none, close, favorite }

class KCardSkeleton extends StatelessWidget {
  const KCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _PosterSkeleton(),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _line(width: 240),
                const SizedBox(height: 8),
                _line(width: 120),
                const SizedBox(height: 16),
                _line(width: 60),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _line(width: 20),
                    const SizedBox(width: 4),
                    _line(width: 36),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _line({required double width}) {
    return Container(
      height: 12,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.neutral800,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

class KCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  final String? season;
  final String? episode;
  final String? rating;
  final String? status;
  final List<String>? genres;
  final KCardImageProportion imageProportion;

  final VoidCallback? onTap;
  final VoidCallback? onTrailingTap;
  final KCardTrailing trailing;

  const KCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.season,
    this.episode,
    this.rating,
    this.status,
    this.genres,
    this.imageProportion = KCardImageProportion.vertical,
    this.onTap,
    this.onTrailingTap,
    this.trailing = KCardTrailing.none,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Poster(imageUrl: imageUrl, imageProportion: imageProportion),

            const SizedBox(width: 14),

            Expanded(child: _textSection()),

            if (trailing != KCardTrailing.none) ...[
              const SizedBox(width: 12),
              _TrailingIcon(type: trailing, onTap: onTrailingTap),
            ],
          ],
        ),
      ),
    );
  }

  Widget _textSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppTokens.onPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),

        if (season != null || episode != null) ...[
          const SizedBox(height: 6),
          Row(
            children: [
              if (season != null)
                Text(
                  season!,
                  style: const TextStyle(
                    color: AppTokens.onSecondary,
                    fontSize: 13,
                  ),
                ),
              if (season != null && episode != null)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    '•',
                    style: TextStyle(
                      color: AppTokens.onSecondary,
                      fontSize: 12,
                    ),
                  ),
                ),
              if (episode != null)
                Text(
                  "Episode ${episode!}",
                  style: const TextStyle(
                    color: AppTokens.onSecondary,
                    fontSize: 13,
                  ),
                ),
            ],
          ),
        ],

        if (genres != null && genres!.isNotEmpty) ...[
          const SizedBox(height: 6),
          Row(
            children: genres!
                .sublist(0, genres!.length.clamp(0, 3))
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: KChip(label: e),
                  ),
                )
                .toList(growable: false),
          ),
        ],

        if (rating != null) ...[
          const SizedBox(height: 6),
          Row(
            children: [
              SvgIcon.star(13, AppTokens.notifBadge).widget,
              const SizedBox(width: 4),
              Text(
                rating!,
                style: const TextStyle(
                  color: AppTokens.onSecondary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 8),
              if (status != null)
                Text(
                  status!,
                  style: const TextStyle(
                    color: AppTokens.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

class _PosterSkeleton extends StatelessWidget {
  const _PosterSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.neutral800,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class _Poster extends StatelessWidget {
  final String imageUrl;
  final KCardImageProportion imageProportion;

  const _Poster({required this.imageUrl, required this.imageProportion});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 72,
        height: imageProportion == KCardImageProportion.vertical ? 100 : 72,
        fit: BoxFit.cover,
        placeholder: (_, __) => const _PosterSkeleton(),
        errorWidget: (_, __, ___) {
          return Container(
            width: 72,
            height: imageProportion == KCardImageProportion.vertical ? 100 : 72,
            decoration: BoxDecoration(
              color: AppColors.neutral800,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(
                Icons.broken_image,
                size: 24,
                color: AppColors.errorBadge,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TrailingIcon extends StatelessWidget {
  final KCardTrailing type;
  final VoidCallback? onTap;

  const _TrailingIcon({required this.type, this.onTap});

  @override
  Widget build(BuildContext context) {
    String icon;
    Color color;

    switch (type) {
      case KCardTrailing.close:
        icon = SvgIcon.closeIcon;
        color = AppTokens.onSecondary.withValues(alpha: 0.6);
        break;
      case KCardTrailing.favorite:
        icon = SvgIcon.bookmarkIcon;
        color = AppTokens.onSecondary;
        break;
      case KCardTrailing.none:
        return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: onTap,
      child: SvgIconData(path: icon, size: 18, color: color).widget,
    );
  }
}
